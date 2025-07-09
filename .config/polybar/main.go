package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

func main() {
	// Read battery status
	statusBytes, err := ioutil.ReadFile("/sys/class/power_supply/BAT0/status")
	if err != nil {
		log.Fatalf("Failed to read status: %v", err)
	}
	status := strings.TrimSpace(string(statusBytes))

	// Read battery capacity
	capacityBytes, err := ioutil.ReadFile("/sys/class/power_supply/BAT0/capacity")
	if err != nil {
		log.Fatalf("Failed to read capacity: %v", err)
	}
	capacityStr := strings.TrimSpace(string(capacityBytes))
	capacity, err := strconv.Atoi(capacityStr)
	if err != nil {
		log.Fatalf("Invalid capacity number: %v", err)
	}

	// Choose color based on capacity
	var color string
	switch {
	case capacity >= 80:
		color = "#00FF00" // green
	case capacity >= 40:
		color = "#FFFF00" // yellow
	case capacity >= 20:
		color = "#FFA500" // orange
	default:
		color = "#FF0000" // red
	}

	// Compose output string and convert to uppercase
	fullText := strings.ToUpper(fmt.Sprintf("%s %d%%", status, capacity))

	// Print formatted output (for Polybar)
	fmt.Printf("%%{F%s}%s%%{F-}\n", color, fullText)
}
