#!/bin/bash

# Example project structure. 
# You can customize PROJECT, BACKEND, FRONTEND, VENV, Docker containers, databases, etc.
PROJECT="$HOME/workspaces/exampleProject"
BACKEND="$PROJECT/backend"
FRONTEND="$PROJECT/frontend"

# --- WORKSPACE 1: NVIM ---
# 1. Switch to the workspace where NVIM should open
hyprctl dispatch movetoworkspace 1

# 2. Launch a terminal executing NVIM (or any command)
# For demonstration, we simply echo a message and keep the terminal open for 3 seconds
# In your real workflow, you could replace this with: alacritty -e bash -c "nvim $PROJECT"
alacritty -e bash -c "echo 'Executing NVIM for file exampleApp.py'; sleep 3"

# --- WORKSPACE 3: TMUX ---
# 3. Switch to the workspace where TMUX sessions should run
# Add a short delay to ensure proper workspace transition
sleep 0.5
hyprctl dispatch workspace 3

# 4. Launch TMUX example script in a new terminal
# It's recommended to name TMUX scripts with the prefix 'tmux_' followed by the project name for consistency
alacritty -e bash -c "$HOME/workspaces/ow/tmux_example.sh" &
