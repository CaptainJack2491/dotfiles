
# setting mic to toggle
pactl set-source-mute @DEFAULT_SOURCE@ toggle 

# setting the brightness accordingly

DEVICE="platform::micmute"

current_brightness=$(brightnessctl -d "$DEVICE" get)

if [ "$current_brightness" -eq 1 ]; then
  brightnessctl -d "$DEVICE" set 0
else
  brightnessctl -d "$DEVICE" set 1
fi
