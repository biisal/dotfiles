#!/bin/bash

# Get the query from rofi
query=$(rofi -dmenu -p "Launch or Search: " -theme-str 'window {width: 50%;}')

# Exit if no input
if [[ -z "$query" ]]; then
    exit 0
fi

# Try to find matching applications
matches=$(rofi -show drun -filter "$query" -no-show-icons -format 'd' | head -1)

# If we found a match, launch it
if [[ -n "$matches" ]]; then
    # Launch the application
    rofi -show drun -filter "$query" -auto-select -no-show-icons > /dev/null 2>&1 &
else
    # No matches found, search on web
    # Replace 'firefox' with your preferred browser
    firefox "https://www.google.com/search?q=$(echo "$query" | sed 's/ /+/g')" &
fi
