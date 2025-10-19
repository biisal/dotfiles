#! /bin/bash

set +e

killall waybar
waybar  -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css > /dev/null 2>&1 &
