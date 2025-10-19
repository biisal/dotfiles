#!/bin/bash

config="$HOME/.config/mango/waybar/config.jsonc"
style="$HOME/.config/mango/waybar/style.css"
cmd="waybar -c $config -s $style"

if pgrep -f "waybar -c $config -s $style" > /dev/null; then
    pkill -f "waybar -c $config -s $style"
else
    $cmd &
fi
