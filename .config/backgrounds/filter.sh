#!/bin/bash

INPUT="$1"
OUTPUT="$2"

ffmpeg -y -i "$INPUT" -vf "
eq=contrast=1.05:brightness=0.02:saturation=0.9,
colorbalance=rs=0.05:gs=0.02:bs=-0.02:rm=0.03:gm=0.01:bm=-0.01,
curves=all='0/0.05 0.2/0.25 0.5/0.52 0.8/0.78 1/0.95'
" -frames:v 1 "$OUTPUT"
