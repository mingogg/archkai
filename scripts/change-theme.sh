#!/usr/bin/env bash

THEMES_DIR="$HOME/archkai/theme"
CURRENT_LINK="$HOME/.config/theme/current"

selected_theme=$(
  find "$THEMES_DIR" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | walker -d -p "Select theme"
  )

[ -z "$selected_theme" ] && exit 0

ln -sfn "$THEMES_DIR/$selected_theme" "$CURRENT_LINK"

relaunch-apps
