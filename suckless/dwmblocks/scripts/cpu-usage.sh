#!/bin/sh
top -bn1 | grep "Cpu(s)" | awk '{printf "CPU: %d%%", $2+$4}'
