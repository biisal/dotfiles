#!/bin/zsh

if [ "$1" = "crop" ]; then
  SCREENSHOT_DIR=~/Pictures/crop-screenshots
  FILE="$SCREENSHOT_DIR/crop-screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
  MSG="Crop-Screenshot Saved & Copied to $FILE"
  SHOT_COMMAND="scrot -s \"$FILE\""
else 
  SCREENSHOT_DIR=~/Pictures/full-screenshots
  FILE="$SCREENSHOT_DIR/full-screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
  MSG="Full-Screenshot Saved & Copied"
  SHOT_COMMAND="scrot \"$FILE\""
fi

mkdir -p "$SCREENSHOT_DIR"

eval $SHOT_COMMAND && xclip -selection clipboard -t image/png -i "$FILE" && notify-send "$MSG"

