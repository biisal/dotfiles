#!/bin/bash

IS_UP=false
[[ "$1" == "up" ]] && IS_UP=true
BAR=someblocks 
[[ "$2" == "waybar" ]] && BAR=waybar
SIGNAL=${3:-RTMIN+8}

RATE=10
(pactl list sinks | grep -q "Active Port: analog-output-headphones") && RATE=1 

if $IS_UP; then
	pw-volume change +${RATE}%
else
	pw-volume change -${RATE}%
fi

pkill -$SIGNAL $BAR
