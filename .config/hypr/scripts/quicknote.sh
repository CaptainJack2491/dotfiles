#!/bin/bash

# Define the path to your notes file
NOTES_FILE="$HOME/Documents/quick_notes.txt"

# Ensure the directory exists
mkdir -p "$(dirname "$NOTES_FILE")"

# --- Yad Command ---
# --text-info: Use a text information box for multi-line input
# --editable: Make the text information box editable
# --wrap: Wrap text within the text area
# --width, --height: Set the initial size (in pixels)
# --title: Set the window title (CRITICAL for Hyprland rules)
# --button: Define custom buttons. "Text!Icon:ExitCode"
#           Using standard GTK icon names can make them look modern if your theme supports them.
# --no-buttons: Disable default OK/Cancel (we define custom ones) - This isn't strictly needed as --button overrides
# --skip-taskbar: Don't show the window in the taskbar/dock - good for a quick utility
# --undecorated: Removes window manager decorations - could be used instead of Hyprland's noborder, but Hyprland rule is often better
note_content=$(yad \
    --text-info --editable --wrap \
    --width=450 --height=250 \
    --title="quick_note" \
    --no-buttons \
    --skip-taskbar)

# Check the exit code of yad (0 for Save, 1 for Cancel/Close)
if [ $? -eq 0 ]; then
    # Get content from the yad output
    # `yad --text-info` outputs the text area content to stdout if a button with exit code 0 is clicked
    # We already captured this in the note_content variable above

    # If content is not empty after stripping whitespace
    if [ -n "$(echo "$note_content" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')" ]; then
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")
        echo "---" >> "$NOTES_FILE" # Separator
        echo "$timestamp" >> "$NOTES_FILE"
        echo "$note_content" >> "$NOTES_FILE"
        echo "" >> "$NOTES_FILE" # Add a blank line after the note
    fi
fi

# Exit the script
exit 0
