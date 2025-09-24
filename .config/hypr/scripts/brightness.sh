#!/usr/bin/env bash
set -euo pipefail

# Get current brightness percent (integer)
if ! cur=$(brightnessctl g 2>/dev/null) || ! max=$(brightnessctl m 2>/dev/null); then
  echo "brightnessctl not available" >&2
  exit 1
fi
curp=$(( cur * 100 / max ))

# Prompt user with wofi (dmenu mode). Default value shown is current percent.
input="$(printf '%s\n' "$curp" | wofi --dmenu -p "Brightness (%)")" || exit 0

# Trim whitespace and optional percent sign
input="$(printf '%s' "$input" | tr -d '[:space:]')"
input="${input%\%}"

# Validate integer
if ! [[ "$input" =~ ^[0-9]+$ ]]; then
  notify-send "Brightness" "Invalid input: '$input' (enter 0-100)"
  exit 1
fi

# Clamp 0-100
if [ "$input" -lt 0 ]; then input=0; fi
if [ "$input" -gt 100 ]; then input=100; fi

# Try running brightnessctl; fall back to sudo if permission denied
if brightnessctl s "${input}%" >/dev/null 2>&1; then
  notify-send "Brightness" "Set to ${input}%"
else
  if command -v sudo >/dev/null 2>&1; then
    sudo brightnessctl s "${input}%"
    notify-send "Brightness" "Set to ${input}% (via sudo)"
  else
    notify-send "Brightness" "Failed to set brightness — permissions?"
    exit 1
  fi
fi

