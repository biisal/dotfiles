#!/bin/bash
# will be excuted from /etc/udev/rules.d/90-charger.rules

export DISPLAY=:0
export XAUTHORITY=/home/avisek/.Xauthority
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
PLUG_MESSAGE="Boosting Power 🔋!!"
UNPLUG_MESSAGE="Unplugged"

if [[ "$1" != "plug" && "$1" != "unplug" ]]; then
	echo "usage: $0 [plug|unplug]"
	exit 0
fi
if [ "$1" == "unplug" ]; then
	notify-send "$UNPLUG_MESSAGE"
else
	notify-send "$PLUG_MESSAGE"
fi
sudo -u avisek XDG_RUNTIME_DIR="/run/user/$(id -u avisek)" polybar-msg action '#battery.hook.0'
