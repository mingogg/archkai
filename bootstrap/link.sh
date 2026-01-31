#!/usr/bin/env bash

# Ensures there is a backup in case the folders exists, if not, creates the symlink to the repo
safe_copy(){
    local target="$1"
    local dest="$2"

    if [ -e "$dest" ]; then
        # Hacer backup con timestamp
        mv "$dest" "${dest}.backup.$(date +%s)"
    fi

    cp -r "$target" "$dest"
}

safe_link(){
  local target="$1"
  local link="$2"

  if [ -L "$link" ]; then
    ln -sfn "$target" "$link"

  elif [ -e "$link" ]; then
    mv "$link" "${link}.backup.$(date +%s)"
    ln -sfn "$target" "$link"

  else
    ln -sfn "$target" "$link"
  fi
}

safe_link_root(){
  local target="$1"
  local link="$2"

  sudo mkdir -p "$(dirname "$link")"
  sudo ln -sfn "$target" "$link"
}

BLUE="\033[34m"
GREEN="\033[32m"
RESET="\033[0m"

# If there is a config folder that's needed from the dotfiles, it goes from
# ~/gadearch/config to ~/.config/folder, else if there's a THEME needed, it goes from
# ~/.config/theme/current/folder to ~/.config/folder

REAL_HOME="$HOME"
CONFIG="$REAL_HOME/.config"
DOTFILES="$REAL_HOME/archkai"

echo -e "\n${BLUE}===================================${RESET}"
echo -e "${GREEN}[ LINK ] applyin dotfiles symlinks${RESET}"
echo -e "${BLUE}===================================${RESET}\n"

# Ensure base config directory exists (single source of truth for all symlinks)
mkdir -p "$CONFIG"

# Create the Theme system
safe_copy "$DOTFILES/theme" "$CONFIG/theme"
safe_link "$DOTFILES/theme/default" "$CONFIG/theme/current"

# Hyprland
safe_copy "$DOTFILES/config/hypr" "$CONFIG/hypr"

# Nvim
safe_copy "$DOTFILES/config/nvim" "$CONFIG/nvim"

# Waybar
safe_copy "$DOTFILES/config/waybar" "$CONFIG/waybar"

# BASH
safe_copy "$DOTFILES/config/bashrc/.bashrc" "$HOME/.bashrc"

# Walker
safe_copy "$DOTFILES/config/walker" "$CONFIG/walker"

# Ly (login manager)
echo -e "${BLUE}[ INFO ] Linking login manager system files (sudo required)${RESET}"
safe_link_root "$DOTFILES/config/ly/config.ini" "/etc/ly/config.ini"

# Mako
safe_copy "$DOTFILES/config/mako" "$CONFIG/mako"

# btop
safe_copy "$DOTFILES/config/btop" "$CONFIG/btop"

# wiremix
safe_copy "$DOTFILES/config/wiremix" "$CONFIG/wiremix"

# tmux
safe_copy "$DOTFILES/config/tmux" "$CONFIG/tmux"

# alacritty
safe_copy "$DOTFILES/config/alacritty" "$CONFIG/alacritty"

# Workspaces
safe_copy "$DOTFILES/workspaces" "$HOME/workspaces"

# scripts executables in path
mkdir -p "$HOME/.local/bin"
for script in ~/archkai/scripts/*.sh; do
  [ -e "$script" ] || continue
  name=$(basename "$script" .sh)
  ln -sf "$script" "$HOME/.local/bin/$name"
done
