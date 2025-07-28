package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	// Read battery status
	statusBytes, err := os.ReadFile("/sys/class/power_supply/BAT0/status")
	if err != nil {
		log.Fatalf("Failed to read status: %v", err)
	}
	status := strings.TrimSpace(string(statusBytes))

	// Read battery capacity
	capacityBytes, err := os.ReadFile("/sys/class/power_supply/BAT0/capacity")
	if err != nil {
		log.Fatalf("Failed to read capacity: %v", err)
	}
	capacityStr := strings.TrimSpace(string(capacityBytes))
	capacity, err := strconv.Atoi(capacityStr)
	if err != nil {
		log.Fatalf("Invalid capacity number: %v", err)
	}

	type iconColor struct {
		normalIcon string
		color      string
		chargeIcon string
	}
	iconColors := []iconColor{
		{
			normalIcon: "",
			color:      "#FF0000", // red
			chargeIcon: "󰢜",
		},
		{
			normalIcon: "",
			color:      "#FFA500", // orange
			chargeIcon: "󰂇",
		},
		{
			normalIcon: "",
			color:      "#FFFF00", // yellow
			chargeIcon: "󰢝",
		},
		{
			normalIcon: "",
			color:      "#00FFFF", // cyan
			chargeIcon: "󰢞",
		},
		{
			chargeIcon: "󰂅",
			color:      "#00FF00", // green
			normalIcon: "",
		},
	}
	ic := iconColors[capacity/25]
	finalIcon := ic.normalIcon
	finalColor := ic.color
	if status == "Charging" {
		finalIcon = ic.chargeIcon
		finalColor = "#00FFFF"
	}
	fullText := strings.ToUpper(fmt.Sprintf("%s %d%%", finalIcon, capacity))

	fmt.Printf("%%{F%s}%s%%{F-}\n", finalColor, fullText)
}
