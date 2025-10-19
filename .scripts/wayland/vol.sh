#!/bin/bash

IS_UP=false
[[ "$1" == "up" ]] && IS_UP=true

RATE=10
(pactl list sinks | grep -q "Active Port: analog-output-headphones") && RATE=1 

if $IS_UP; then
	pw-volume change +${RATE}%
else
	pw-volume change -${RATE}%
fi

pkill -RTMIN+8 waybar
