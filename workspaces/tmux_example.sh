#!/bin/bash

# Create a new TMUX session in detached mode
SESSION="EXAMPLE"
tmux new-session -d -s "$SESSION" -c "$HOME/workspaces/exampleProject"

# Split the session vertically to simulate backend/frontend separation
tmux split-window -v -c "$HOME/workspaces/exampleProject/backend"

# --- Example commands ---
# 1. In the first pane, simulate lifting the backend
# 2. In the second pane, simulate lifting the frontend
tmux send-keys -t "$SESSION":0.0 "echo 'Starting backend...'; sleep 3" C-m
tmux send-keys -t "$SESSION":0.1 "echo 'Starting frontend...'; sleep 3" C-m

# --- Auto-close the session after demonstration ---
# Sends a message and exits each pane
tmux send-keys -t "$SESSION":0.0 "echo 'Exiting backend pane...'; sleep 2; exit" C-m
tmux send-keys -t "$SESSION":0.1 "echo 'Exiting frontend pane...'; sleep 2; exit" C-m

# --- Creativity and customization ---
# Here in example commands is where you can get creative:
# - Launch your real backend and frontend commands
# - Start Docker containers for your project
# - Open logs in one pane while running tests in another
# - Use environment variables or virtual environments in each pane
# - Add as many panes or windows as you need to speed up your workspace setup
# The goal is to automate repetitive tasks, so when you attach this session, everything is ready to go.

# Select the first pane and attach the session for user viewing
tmux select-pane -t "$SESSION":0.0
tmux attach-session -t "$SESSION"
