#!/bin/zsh

# will be excuted from /etc/udev/rules.d/90-charger.rules

export DISPLAY=:0
export XAUTHORITY=$HOME/.Xauthority
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

notify-send "Boosting Power 🔋!!" 

