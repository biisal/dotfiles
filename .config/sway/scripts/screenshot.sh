#!/bin/zsh

if [ "$1" = "crop" ]; then
  SCREENSHOT_DIR=~/Pictures/crop-screenshots
  FILE="$SCREENSHOT_DIR/crop-screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
  MSG="Crop-Screenshot Saved & Copied"
  AREA=$(slurp)
  SHOT_COMMAND="grim -g \"$AREA\" \"$FILE\""
else
  SCREENSHOT_DIR=~/Pictures/full-screenshots
  FILE="$SCREENSHOT_DIR/full-screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
  MSG="Full-Screenshot Saved & Copied"
  SHOT_COMMAND="grim \"$FILE\""
fi

mkdir -p "$SCREENSHOT_DIR"

eval $SHOT_COMMAND && wl-copy < "$FILE" && notify-send "$MSG"
