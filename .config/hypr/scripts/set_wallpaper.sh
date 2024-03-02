#!/bin/bash


input="${1:-/dev/stdin}"

# Process the input here
while IFS= read -r line; do
  # Print the input here (including arguments)
  echo "Changing the wallpaper to $line"
  if pgrep -x hyprpaper > /dev/null; then
    # If Hyprpaper is running, change the wallpaper
    hyprctl hyprpaper preload $line
    hyprctl hyprpaper wallpaper "eDP-1,$line"
  else
    # If Hyprpaper is not running, start it and then change the wallpaper
    hyprctl hyprpaper preload $line
    hyprctl hyprpaper wallpaper "eDP-1,$line"
    hyprpaper &
    sleep 1
  fi
  wal -i $line
  
done < "$input"

# Exit script with successful execution code
exit 0

# Check if Hyprpaper is running


