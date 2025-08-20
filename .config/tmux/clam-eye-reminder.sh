#!/bin/bash

minute=$(date +%M)

if (( minute % 20 == 0 )); then
	echo "| LOOK AT 20FT AWAY FOR 20 SEC"
	# pane=$(tmux display-message -p '#P')
	# echo "tmux select-pane -t $pane"
	# tmux send-keys -t "$pane"  "$(printf '\x13')" 
	#    (sleep 20; tmux send-keys -t "$pane" "$(printf '\x11')") &
fi


