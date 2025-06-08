#!/usr/bin/env scriptisto

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
//      require (
//          github.com/fatih/color v1.13.0
//      )
// scriptisto-end

import (
	"bufio"
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/fatih/color"
	"log"
	"net/http"
	"os"
	"os/exec"
	"strings"
)

const (
	Model    = "gemini-2.0-flash"
	RoleUser = "user"
)

type Part struct {
	Text string `json:"text"`
}

type History struct {
	Role  string `json:"role"`
	Parts []Part `json:"parts"`
}

type ReqBody struct {
	SystemPromt string    `json:"system_prompt"`
	Model       string    `json:"model"`
	History     []History `json:"history"`
}

type ResBody struct {
	Message string `json:"message"`
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
		Model: Model,
		History: []History{
			{
				Role: RoleUser,
				Parts: []Part{
					{
						Text: diff,
					},
				},
			},
		},
		SystemPromt: prompt,
	}

	data, err := json.Marshal(reqBody)
	if err != nil {
		return "", err
	}
	color.HiMagenta("Generating commit message...")
	req, err := http.NewRequest("POST", "http://api.codeltix.com/api/v1/ai/gemini", bytes.NewBuffer(data))
	if err != nil {
		return "", err
	}
	req.Header.Set("Content-Type", "application/json")

	color.HiMagenta("Ai is thinking...")
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	var resBody ResBody
	if err = json.NewDecoder(resp.Body).Decode(&resBody); err != nil {
		return "", err
	}
	return resBody.Message, nil
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
			log.Fatal(err)
		}
		fmt.Print("Generated commit message : ")
		color.HiGreen(commitMessage)
		fmt.Print("Commit And Push ? [y/n/r(regenerate)]: ")
		input, err := reader.ReadString('\n')
		if err != nil {
			log.Fatal(err)
		}
		input = strings.TrimSpace(input)
		input = strings.ToLower(input)
		switch input {
		case "y":
			cmd := exec.Command("git", "commit", "-m", commitMessage)
			if err := cmd.Run(); err != nil {
				color.HiRed("Commit failed. Check you have added all changes. (git add .)")
			}
			cmd = exec.Command("git", "push", "origin", "main")
			if err := cmd.Run(); err != nil {
				color.HiRed("Push failed : " + err.Error())
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
