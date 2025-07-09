#!/bin/zsh

read bat_status < /sys/class/power_supply/BAT0/status
capacity=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$capacity" -ge 80 ]; then
    color="#00FF00"
elif [ "$capacity" -ge 40 ]; then
    color="#FFFF00"
elif [ "$capacity" -ge 20 ]; then
    color="#FFA500"
else
    color="#FF0000"
fi

full_text="$bat_status $capacity%"
full_text=${full_text:^^}

echo "%{F$color}$full_text%{F-}"

