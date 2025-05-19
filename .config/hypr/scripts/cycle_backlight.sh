#!/bin/bash

LEVELS="0 1 2 3"
CURRENT_LEVEL=$(brightnessctl -d asus::kbd_backlight get || echo "0")

IFS=' ' read -ra LEVEL_ARRAY <<< "$LEVELS"

current_index=-1
for i in "${!LEVEL_ARRAY[@]}"; do
  if [[ "${LEVEL_ARRAY[$i]}" == "$CURRENT_LEVEL" ]]; then
    current_index="$i"
    break
  fi
done

next_index=$(( (current_index + 1) % ${#LEVEL_ARRAY[@]} ))
next_level="${LEVEL_ARRAY[$next_index]}"

brightnessctl -d asus::kbd_backlight set "$next_level"
