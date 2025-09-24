#!/bin/bash

# Location from the first argument
LOC="$1"

# Default to a location if none is provided
if [ -z "$LOC" ]; then
    LOC="London" # You can change this default city
fi

# HTML encode spaces in the location for the URL
LOCATION_ENCODED=$(echo "$LOC" | sed -e "s/ /%20/g")

# Define the wttr.in format string:
# %c: Weather icon
# %t: Temperature (using &?0 for Celsius)
# %C: Weather condition text
# We use '+' as a separator between the fields for easier parsing.
# WTTR_FORMAT='%c+%t+%C'
WTTR_FORMAT='%w+%t+%C' # Use %w for simple icon char

# Build the wttr.in URL with the location, format, and Celsius flag
WTTR_URL="https://wttr.in/${LOCATION_ENCODED}?format=${WTTR_FORMAT}&?0"

# Fetch weather data from wttr.in silently
WEATHER_DATA=$(curl -s "$WTTR_URL")

# Check if curl failed or returned empty/error data (simple check)
if [ -z "$WEATHER_DATA" ] || [[ "$WEATHER_DATA" =~ "Sorry" ]]; then
    echo '{"text": "N/A", "tooltip": "Could not fetch weather data", "class": "error"}'
    exit 1
fi

# Clean up potential leading/trailing quotes from wttr.in output and trim whitespace
# wttr.in might return ""☀️ +25°C  Sunny"" -> remove quotes, then trim
CLEAN_DATA=$(echo "$WEATHER_DATA" | sed 's/"//g' | xargs)

# Parse the cleaned data using '+' as the delimiter defined in WTTR_FORMAT
# We use 'awk' to split the string based on the '+' delimiter
ICON=$(echo "$CLEAN_DATA" | awk -F'+' '{print $1}' | xargs) # Extract icon and trim whitespace
TEMP=$(echo "$CLEAN_DATA" | awk -F'+' '{print $2}' | xargs) # Extract temperature and trim whitespace
CONDITION=$(echo "$CLEAN_DATA" | awk -F'+' '{print $3}' | xargs) # Extract condition text and trim whitespace

# Generate CSS class name from the condition text
# Convert to lowercase and replace spaces with hyphens for a safer CSS class name
CLASS_NAME=$(echo "$CONDITION" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

# Construct the Waybar JSON output
# Ensure JSON values are properly quoted. Using printf to safely construct the JSON string.
printf '{"text": "%s", "tooltip": "%s %s %s (%s)", "class": "%s"}\n' \
       "$TEMP" \
       "$ICON" \
       "$TEMP" \
       "$CONDITION" \
       "$LOC" \
       "$CLASS_NAME"
