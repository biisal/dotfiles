#!/bin/bash

PERCENTAGE=$(< /sys/class/power_supply/BAT0/capacity)
STATUS=$(< /sys/class/power_supply/BAT0/status)

if [ "$STATUS" = "Charging" ]; then
    echo " $PERCENTAGE%"
    exit 0
else
    [[ $PERCENTAGE -gt 5 ]] && echo "󰂁 $PERCENTAGE%" && exit 0
fi

echo "󰂃 $PERCENTAGE%"
notify-send -u critical -i battery-caution 'Tui Tui Tui!
Low Battery
Please plug in the charger or shut down the system.'
