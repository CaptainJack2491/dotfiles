#!/usr/bin/env bash

# Check if tmux session "notes" exists, create if not
# and attach to it
# if it already exists, 
if ! tmux has-session -t notes; then
  tmux new-session -d -s notes
  tmux send-keys -t notes 'cd ~/vimwiki' Enter
  tmux send-keys -t notes 'nvim' Enter
  kitty --title=notes -e tmux attach-session -t notes &
else
  # Open in special workspace
  hyprctl dispatch togglespecialworkspace
fi

