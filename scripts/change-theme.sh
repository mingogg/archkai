#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/theme"
CURRENT_LINK="$HOME/.config/theme/current"
CONFIG_DIR="$HOME/.config"

selected_theme=$(
    find -L "$THEMES_DIR" -maxdepth 1 -mindepth 1 -type d ! -name current -printf '%f\n' | sort | walker -d -p "Select theme"
)

[ -z "$selected_theme" ] && exit 0

ln -sfn "$THEMES_DIR/$selected_theme" "$CURRENT_LINK"

source "$CURRENT_LINK/colors.sh"

WAYBAR_CONFIG="$CONFIG_DIR/waybar/style.css"
if [ -f "$WAYBAR_CONFIG" ]; then
  sed -i "s|@define-color primary .*;|@define-color primary $PRIMARY_CSS|" "$WAYBAR_CONFIG"
  sed -i "s|@define-color accent .*;|@define-color accent $ACCENT_CSS|" "$WAYBAR_CONFIG"
  sed -i "s|@define-color background .*;|@define-color background $BACKGROUND_CSS|" "$WAYBAR_CONFIG"
  sed -i "s|@define-color foreground .*;|@define-color foreground $FOREGROUND_CSS|" "$WAYBAR_CONFIG"
  sed -i "s|@define-color disabled .*;|@define-color disabled $DISABLED_CSS|" "$WAYBAR_CONFIG"
fi

HYPR_CONFIG="$CONFIG_DIR/hypr/looknfeel.conf"
if [ -f "$HYPR_CONFIG" ]; then
    sed -i "s/^\s*col.active_border\s*=.*$/    col.active_border = $PRIMARY_HYPR/" "$HYPR_CONFIG"
    sed -i "s/^\s*col.inactive_border\s*=.*$/    col.inactive_border = $NEUTRAL_HYPR/" "$HYPR_CONFIG"
    sed -i "s/^\s*col.border_active\s*=.*$/    col.border_active = $PRIMARY_HYPR/" "$HYPR_CONFIG"
    sed -i "s/^\s*col.border_inactive\s*=.*$/    col.border_inactive = $NEUTRAL_HYPR/" "$HYPR_CONFIG"
fi

LY_CONFIG="$CONFIG_DIR/ly/config.ini"
if [ -f "$LY_CONFIG" ]; then
  sed -i "s|^\(cmatrix_fg\s*=\s*\).*|\1$MATRIX_FG|" "$LY_CONFIG"
  sed -i "s|^\(cmatrix_head_col\s*=\s*\).*|\1$MATRIX_HEAD_COL|" "$LY_CONFIG"
  sed -i "s|^\(border_fg\s*=\s*\).*|\1$BORDER_FG|" "$LY_CONFIG"
fi

BTOP_CONFIG="$CONFIG_DIR/btop/btop.conf"
if [ -f "$BTOP_CONFIG" ]; then
  sed -i 's|^color_theme *= *".*"|color_theme = "'"$BTOP_COLORSCHEME"'"|' "$BTOP_CONFIG"
fi

MAKO_CONFIG="$CONFIG_DIR/mako/config"
if [ -f "$MAKO_CONFIG" ]; then
  sed -i "s|^border-color=.*|border-color=$PRIMARY|" "$MAKO_CONFIG"
fi

WIREMIX_CONFIG="$CONFIG_DIR/wiremix/wiremix.toml"
if [ -f "$WIREMIX_CONFIG" ]; then
  sed -i "s|^\(\s*selector\s*=\s*{ fg = \).*\( }\)|\1'$PRIMARY'\2|" "$WIREMIX_CONFIG"
  sed -i "s|^\(\s*tab_marker\s*=\s*{ fg = \).*\( }\)|\1'$PRIMARY'\2|" "$WIREMIX_CONFIG"
  sed -i "s|^\(\s*volume_filled\s*=\s*{ fg = \).*\( }\)|\1'$PRIMARY'\2|" "$WIREMIX_CONFIG"
  sed -i "s|^\(\s*meter_active\s*=\s*{ fg = \).*\( }\)|\1'$PRIMARY'\2|" "$WIREMIX_CONFIG"
  sed -i "s|^\(\s*meter_center_active\s*=\s*{ fg = \).*\( }\)|\1'$PRIMARY'\2|" "$WIREMIX_CONFIG"
  sed -i "s|^\(\s*dropdown_border\s*=\s*{ fg = \).*\( }\)|\1'$PRIMARY'\2|" "$WIREMIX_CONFIG"
  sed -i "s|^\(\s*dropdown_selected\s*=\s*{ fg = \).*\(, add_modifier = \"REVERSED\" }\)|\1'$ACCENT'\2|" "$WIREMIX_CONFIG"
  sed -i "s|^\(\s*tab_selected\s*=\s*{ fg = \).*\( }\)|\1'$ACCENT'\2|" "$WIREMIX_CONFIG"
fi

BASHRC="$HOME/.bashrc"
if [ -f "$BASHRC" ]; then
  sed -i "s|^\(PRIMARY_BASH=\)\".*\"|\1\"${PRIMARY_BASH//\\/\\\\}\"|" "$BASHRC"
  sed -i "s|^\(ACCENT_BASH=\)\".*\"|\1\"${ACCENT_BASH//\\/\\\\}\"|" "$BASHRC"
  sed -i "s|^\(BG_BASH=\)\".*\"|\1\"${BG_BASH//\\/\\\\}\"|" "$BASHRC"
  sed -i "s|^\(FG_BASH=\)\".*\"|\1\"${FG_BASH//\\/\\\\}\"|" "$BASHRC"
  sed -i "s|^\(RESET_BASH=\)\".*\"|\1\"${RESET_BASH//\\/\\\\}\"|" "$BASHRC"
fi

UPDATES="$HOME/.local/update-all"
if [ -f "$UPDATES" ]; then
  sed -i "s|^\(PRIMARY_BASH=\)\".*\"|\1\"${PRIMARY_BASH//\\/\\\\}\"|" "$UPDATES"
  sed -i "s|^\(ACCENT_BASH=\)\".*\"|\1\"${ACCENT_BASH//\\/\\\\}\"|" "$UPDATES"
  sed -i "s|^\(BG_BASH=\)\".*\"|\1\"${BG_BASH//\\/\\\\}\"|" "$UPDATES"
  sed -i "s|^\(FG_BASH=\)\".*\"|\1\"${FG_BASH//\\/\\\\}\"|" "$UPDATES"
  sed -i "s|^\(RESET_BASH=\)\".*\"|\1\"${RESET_BASH//\\/\\\\}\"|" "$UPDATES"
  sed -i "s|^\(GIT_CLEAN_BASH=\)\".*\"|\1\"${GIT_CLEAN_BASH//\\/\\\\}\"|" "$UPDATES"
  sed -i "s|^\(GIT_DIRTY_BASH=\)\".*\"|\1\"${GIT_DIRTY_BASH//\\/\\\\}\"|" "$UPDATES"
fi

GIT_PROMPT="$HOME/.local/bash-functions"
if [ -f "$GIT_PROMPT" ]; then
  sed -i "s|^\(PRIMARY_BASH=\)\".*\"|\1\"${PRIMARY_BASH//\\/\\\\}\"|" "$GIT_PROMPT"
  sed -i "s|^\(GIT_CLEAN_BASH=\)\".*\"|\1\"${GIT_CLEAN_BASH//\\/\\\\}\"|" "$GIT_PROMPT"
  sed -i "s|^\(GIT_DIRTY_BASH=\)\".*\"|\1\"${GIT_DIRTY_BASH//\\/\\\\}\"|" "$GIT_PROMPT"
fi

WALKER_CONFIG="$CONFIG_DIR/walker/themes/current/style.css"
if [ -f "$WALKER_CONFIG" ]; then
  sed -i "s|@define-color primary .*;|@define-color primary $PRIMARY_CSS|" "$WALKER_CONFIG"
  sed -i "s|@define-color foreground .*;|@define-color foreground $FOREGROUND_CSS|" "$WALKER_CONFIG"
fi

# Nautilus
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"

relaunch-apps
notify-send -t 3000 "Update theme" "Theme has been updated succesfully"
