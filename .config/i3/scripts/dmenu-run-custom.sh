#!/bin/bash
# ~/.config/dmenu_run_custom.sh

# List your favorite apps first
echo -e "brave\nfirefox\ncode\n$(dmenu_path)" | sort -u | dmenu -i -p "Run:" | xargs -r nohup setsid >/dev/null 2>&1
