#!/bin/bash

app="${1:-Duckduckgo}"
isNewWindow="${2:-false}"
query=$(rofi -dmenu -i -p "Search on $app:" < /dev/null)
if [ -z "$query" ]; then
	exit
fi

if [ "$app" == "youtube" ]; then
	search_url="https://www.youtube.com/results?search_query=$query"
else
	search_url="https://duckduckgo.com/?q=$query"
fi


[[ "$isNewWindow" == true ]] && brave --new-window "$search_url" || brave "$search_url"
