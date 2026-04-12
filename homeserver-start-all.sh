#!/usr/bin/bash

# Get the current session name
TARGET=$(tmux display-message -p '#S')

# tmux new-window -a -t "$TARGET" -n "mqtt"
# tmux send-keys -t "$TARGET:mqtt" "./start-mosquitto.sh" C-m

tmux new-window -a -t "$TARGET" -n "z2m"
tmux send-keys -t "$TARGET:z2m" "./start-z2m.sh" C-m

tmux new-window -a -t "$TARGET" -n "lights"
tmux send-keys -t "$TARGET:lights" "./lights.py" C-m
