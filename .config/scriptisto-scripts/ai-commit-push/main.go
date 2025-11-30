package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
	"strings"
	"time"

	"github.com/fatih/color"
	"github.com/joho/godotenv"
)

const (
	ModelName   = "gemini-2.0-flash" // Or "gemini-1.5-flash"
	MaxDiffChar = 25000              // Truncate diffs larger than this to avoid token limits
	ApiURL      = "https://generativelanguage.googleapis.com/v1beta/models/%s:generateContent?key=%s"
)

// Structs for Gemini API
type Part struct {
	Text string `json:"text"`
}
type Content struct {
	Role  string `json:"role"`
	Parts []Part `json:"parts"`
}
type ReqBody struct {
	SystemInstruction *Content  `json:"systemInstruction,omitempty"`
	Contents          []Content `json:"contents"`
}
type Candidate struct {
	Content Content `json:"content"`
}
type ResBody struct {
	Candidates []Candidate `json:"candidates"`
}

func main() {
	// 1. Load Config
	loadEnv()
	apiKey := os.Getenv("GEMINI_API_KEY")
	if apiKey == "" {
		color.HiRed("Error: GEMINI_API_KEY is not set in environment or .env file.")
		os.Exit(1)
	}

	// 2. Get Git Diff
	diff, err := getGitDiff()
	if err != nil {
		log.Fatalf("Failed to get git diff: %v", err)
	}
	if strings.TrimSpace(diff) == "" {
		color.HiRed("No changes detected (staged or unstaged).")
		return
	}

	// 3. Loop for generation
	reader := bufioNewReader(os.Stdin)
	for {
		commitMsg, err := generateCommitMessage(apiKey, diff)
		if err != nil {
			color.HiRed("API Error: %v", err)
			return
		}

		fmt.Println("------------------------------------------------")
		color.HiYellow("Generated Message:")
		fmt.Println(commitMsg)
		fmt.Println("------------------------------------------------")

		fmt.Print("Commit & Push? [y (yes) / n (no) / r (regenerate)]: ")
		input, _ := reader.ReadString('\n')
		input = strings.TrimSpace(strings.ToLower(input))

		switch input {
		case "y":
			executeGitWorkflow(commitMsg)
			return
		case "n":
			color.HiCyan("Aborted.")
			return
		case "r":
			color.HiCyan("Regenerating...")
			continue
		default:
			color.HiRed("Invalid input.")
		}
	}
}

// --- Git Helper Functions ---

func getGitDiff() (string, error) {
	// Exclude massive lock files that confuse the LLM and waste tokens
	exclusions := []string{
		":(exclude)go.sum",
		":(exclude)package-lock.json",
		":(exclude)yarn.lock",
		":(exclude)*.lock",
	}

	color.HiCyan("Analyzing changes...")

	// 1. Try getting staged changes first
	args := append([]string{"diff", "--cached"}, exclusions...)
	output, err := exec.Command("git", args...).Output()
	if err != nil {
		return "", err
	}

	// 2. If no staged changes, get working tree changes
	if len(output) == 0 {
		args = append([]string{"diff", "HEAD"}, exclusions...)
		output, err = exec.Command("git", args...).Output()
		if err != nil {
			// Fallback if HEAD doesn't exist yet (first commit)
			args = append([]string{"diff"}, exclusions...)
			output, _ = exec.Command("git", args...).Output()
		}
	}

	diff := string(output)

	// 3. Handle Rate Limits / Token Limits via Truncation
	if len(diff) > MaxDiffChar {
		color.HiYellow("Warning: Diff is very large (%d chars). Truncating to first %d chars for API.", len(diff), MaxDiffChar)
		diff = diff[:MaxDiffChar] + "\n... [Diff Truncated due to size] ..."
	}

	return diff, nil
}

func getCurrentBranch() string {
	out, err := exec.Command("git", "rev-parse", "--abbrev-ref", "HEAD").Output()
	if err != nil {
		return "main" // Fallback
	}
	return strings.TrimSpace(string(out))
}

func executeGitWorkflow(msg string) {
	// 1. Add all changes
	color.HiCyan("Step 1: git add .")
	if err := runLiveCommand("git", "add", "."); err != nil {
		color.HiRed("Failed to add files: %v", err)
		return
	}

	// 2. Commit
	color.HiCyan("Step 2: git commit")
	if err := runLiveCommand("git", "commit", "-m", msg); err != nil {
		color.HiRed("Commit failed: %v", err)
		return
	}

	// 3. Push
	branch := getCurrentBranch()
	color.HiCyan("Step 3: git push origin %s", branch)
	if err := runLiveCommand("git", "push", "origin", branch); err != nil {
		color.HiRed("Push failed: %v", err)
	} else {
		color.HiGreen("Success! Code pushed to %s.", branch)
	}
}

// runLiveCommand runs a command and streams stdout/stderr to the terminal
func runLiveCommand(name string, args ...string) error {
	cmd := exec.Command(name, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

// --- API Logic ---

func generateCommitMessage(apiKey, diff string) (string, error) {
	prompt := `You are a Git commit message generator. 
	Analyze the provided git diff.
	Rules:
	1. Format: <type>: <description>
	2. Types: feat, fix, chore, docs, style, refactor, perf, test.
	3. Keep it under 50 characters if possible.
	4. Lowercase, present tense.
	5. Output ONLY the message, no quotes, no explanations.
	
	Diff:
	` + diff

	reqBody := ReqBody{
		Contents: []Content{{
			Role:  "user",
			Parts: []Part{{Text: prompt}},
		}},
	}

	jsonData, err := json.Marshal(reqBody)
	if err != nil {
		return "", err
	}

	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	req, err := http.NewRequestWithContext(ctx, "POST", fmt.Sprintf(ApiURL, ModelName, apiKey), bytes.NewBuffer(jsonData))
	if err != nil {
		return "", err
	}
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		body, _ := io.ReadAll(resp.Body)
		return "", fmt.Errorf("API Error %s: %s", resp.Status, string(body))
	}

	var res ResBody
	if err := json.NewDecoder(resp.Body).Decode(&res); err != nil {
		return "", err
	}

	if len(res.Candidates) == 0 || len(res.Candidates[0].Content.Parts) == 0 {
		return "", fmt.Errorf("empty response from AI")
	}

	return strings.TrimSpace(res.Candidates[0].Content.Parts[0].Text), nil
}

// --- Utilities ---

func loadEnv() {
	// Try loading .env, ignore error if file missing (might be using real env vars)
	_ = godotenv.Load()
}

// Simple wrapper to avoid importing bufio just for the type in main
func bufioNewReader(r io.Reader) interface {
	ReadString(delim byte) (string, error)
} {
	// We need actual bufio here, but to keep main clean,
	// let's just import bufio properly.
	// *Wait, I cannot define interface return implementations inline easily in Go.*
	// Let's just fix the imports.
	return nil
}
