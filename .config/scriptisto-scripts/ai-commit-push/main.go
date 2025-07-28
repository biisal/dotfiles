// #!/usr/bin/env scriptisto

package main

// scriptisto-begin
// script_src: main.go
// build_once_cmd: go mod tidy
// build_cmd: go build -o script
// replace_shebang_with: //
// files:
//  - path: go.mod
//    content: |
//      module example.com/a/b
//      go 1.20
//      require (
//          github.com/fatih/color v1.13.0
//          github.com/joho/godotenv v1.5.1
//      )
// scriptisto-end

import (
	"bufio"
	"bytes"
	_ "embed"
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

//go:embed .env
var embeddedEnv string

var (
	GEMINI_API_KEY string
)

func init() {
	// Parse and set env variables from embedded .env
	envMap, err := godotenv.Parse(strings.NewReader(embeddedEnv))
	if err != nil {
		log.Fatalf("Failed to parse embedded .env: %v", err)
	}
	for k, v := range envMap {
		os.Setenv(k, v)
	}

	GEMINI_API_KEY = os.Getenv("GEMINI_API_KEY")
	if GEMINI_API_KEY == "" {
		color.HiRed("Please embed GEMINI_API_KEY in the .env file.")
		os.Exit(1)
	}
}

const (
	MODEL      = "gemini-2.0-flash"
	RoleUser   = "user"
	RoleSystem = "system"
)

type Part struct {
	Text string `json:"text"`
}

type Content struct {
	Role  string `json:"role"`
	Parts []Part `json:"parts"`
}

type ReqBody struct {
	SystemInstruction Content   `json:"systemInstruction"`
	Contents          []Content `json:"contents"`
}

type Candidate struct {
	Content Content `json:"content"`
}

type ResBody struct {
	Candidates []Candidate `json:"candidates"`
}

func generateCommitMessage(diff string) (string, error) {
	prompt := `You are a Git commit message generator.
Analyze the given Git diff and respond with a clear, meaningful, and brief commit message.

Instructions:
- If the change is cosmetic (e.g., added blank lines, minor text like "please ignore it"), respond with: "minor formatting change" or "non-functional text update".
- If the diff includes real logic/code changes, summarize them accurately.
- Avoid making up reasons or context.
- Use lowercase, present-tense, concise action verbs (e.g., "fix", "add", "remove", "refactor").
- Do NOT include file names or paths.
- Max 10–12 words.
Now generate the commit message for this diff:`

	reqBody := ReqBody{
		Contents: []Content{
			{
				Role: RoleUser,
				Parts: []Part{
					{
						Text: diff,
					},
				},
			},
		},
		SystemInstruction: Content{
			Role: RoleSystem,
			Parts: []Part{
				{
					Text: prompt,
				},
			},
		},
	}

	data, err := json.Marshal(reqBody)
	if err != nil {
		return "", err
	}

	color.HiMagenta("Generating commit message...")
	req, err := http.NewRequest("POST",
		fmt.Sprintf("https://generativelanguage.googleapis.com/v1beta/models/%s:generateContent?key=%s", MODEL, GEMINI_API_KEY),
		bytes.NewBuffer(data))
	if err != nil {
		return "", err
	}
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return "", fmt.Errorf("failed to generate commit message while calling API: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		body := &bytes.Buffer{}
		body.ReadFrom(resp.Body)
		return "", fmt.Errorf("Bad Response: %w , Response: %s", err, body.String())
	}

	var resBody ResBody
	if err = json.NewDecoder(resp.Body).Decode(&resBody); err != nil {
		bodyBytes, _ := io.ReadAll(resp.Body)
		fmt.Println("Body : ", string(bodyBytes), "\nStatus : ", resp.Status)
		return "", fmt.Errorf("failed to decode response: %w", err)
	}
	return resBody.Candidates[0].Content.Parts[0].Text, nil
}

func main() {
	color.HiCyan("Getting changes...")
	cmd := exec.Command("git", "diff", "HEAD")
	output, err := cmd.Output()
	if err != nil {
		log.Fatal(err)
	}
	if len(output) == 0 {
		color.HiRed("No changes detected.")
		return
	}

	reader := bufio.NewReader(os.Stdin)
	for {
		commitMessage, err := generateCommitMessage(string(output))
		if err != nil {
			color.HiRed("Error while generating commit message: " + err.Error())
			time.Sleep(2 * time.Second)
			return
		}
		fmt.Print("Generated commit message: ")
		color.HiGreen(commitMessage)
		fmt.Print("Commit and push? [y/n/r (regenerate)]: ")
		input, err := reader.ReadString('\n')
		if err != nil {
			log.Fatal(err)
		}
		input = strings.TrimSpace(strings.ToLower(input))
		switch input {
		case "y":
			cmd := exec.Command("git", "commit", "-m", commitMessage)
			if err := cmd.Run(); err != nil {
				color.HiRed("Commit failed. Maybe you forgot to add files? (git add .)")
				color.HiCyan("Should I add all changes? [y/n]: ")
				input, err := reader.ReadString('\n')
				if err != nil {
					log.Fatal(err)
				}
				input = strings.TrimSpace(strings.ToLower(input))
				if input == "y" {
					color.HiCyan("Adding all changes...")
					cmd := exec.Command("git", "add", ".")
					if err := cmd.Run(); err != nil {
						log.Fatal(err)
					}
					cmd = exec.Command("git", "commit", "-m", commitMessage)
					if err := cmd.Run(); err != nil {
						log.Fatal(err)
					}
				}
			}
			cmd = exec.Command("git", "push", "origin", "main")
			if err := cmd.Run(); err != nil {
				color.HiRed("Push failed: " + err.Error())
			} else {
				color.HiGreen("Pushed successfully.")
			}
			return
		case "n":
			return
		case "r":
			continue
		default:
			color.HiRed("Invalid input. Please try again.")
			return
		}
	}
}
