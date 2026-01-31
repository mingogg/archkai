#!/usr/bin/env bash

PROJECT="$HOME/workspaces/exampleProject"
BACKEND="$PROJECT/backend"
FRONTEND="$PROJECT/frontend"

# --- WORKSPACE 1: NVIM ---
hyprctl dispatch workspace 1
sleep 0.5
setsid alacritty -e bash -lc "echo 'Opening NVIM for exampleApp.py'; sleep 3" >/dev/null 2>&1 &

# --- WORKSPACE 3: TMUX ---
sleep 2
hyprctl dispatch workspace 3
sleep 0.5

# Launch TMUX in a separate terminal, so the session stays open
setsid alacritty -e bash -lc "
SESSION='EXAMPLE_TEST'
tmux new-session -A -s \$SESSION -c '$PROJECT' \
  'echo Starting backend; sleep 3; echo Exiting backend; sleep 2' \; \
  split-window -v -c '$BACKEND' 'echo Starting frontend; sleep 3; echo Exiting frontend; sleep 2' \; \
  select-pane -t 0" >/dev/null 2>&1 &
