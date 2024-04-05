#!/bin/sh

cd ~/notes

hyprctl dispatch workspace 10

if $(tmux ls | grep -q notes) > /dev/null; then
  echo "A session of that name already exists."
  echo "attaching to that session.."
  kitty --title=notes -e tmux attach -t notes 
  exit
fi

echo "Starting notes..."
tmux new -s notes -d
tmux send-keys -t notes 'vim' Enter
tmux new-window -t notes 'lazygit'
tmux select-window -t:1


kitty --title=notes -e tmux attach -t notes

hyprctl dispatch workspace 10
hyprctl dispatch workspace 1
