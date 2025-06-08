#!/bin/zsh

bat_status=$(cat /sys/class/power_supply/BAT0/status)
capacity=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$capacity" -ge 80 ]; then
    color="#00FF00"  # green
elif [ "$capacity" -ge 40 ]; then
    color="#FFFF00"  # yellow
elif [ "$capacity" -ge 20 ]; then
	color="#FFA500"  # orange
else
    color="#FF0000"  # red

fi

echo "%{F$color}$bat_status $capacity%%{F-}"
