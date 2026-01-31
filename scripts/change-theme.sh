#!/usr/bin/env bash

THEMES_DIR="$HOME/archkai/theme"
CURRENT_LINK="$HOME/.config/theme/current"
CONFIG_DIR="$HOME/.config"

selected_theme=$(
    find "$THEMES_DIR" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | walker -d -p "Select theme"
)

[ -z "$selected_theme" ] && exit 0

ln -sfn "$THEMES_DIR/$selected_theme" "$CURRENT_LINK"

source "$CURRENT_LINK/colors.sh"

# -----------------------------
# Dynamic replacement of colors
# -----------------------------

# Waybar
WAYBAR_CONFIG="$CONFIG_DIR/waybar/colors.css"
if [ -f "$WAYBAR_CONFIG" ]; then
    sed -i "s/--primary:.*/--primary: $PRIMARY_CSS/" "$WAYBAR_CONFIG"
    sed -i "s/--accent:.*/--accent: $ACCENT_CSS/" "$WAYBAR_CONFIG"
    sed -i "s/--background:.*/--background: $BACKGROUND_CSS/" "$WAYBAR_CONFIG"
    sed -i "s/--foreground:.*/--foreground: $FOREGROUND_CSS/" "$WAYBAR_CONFIG"
    sed -i "s/--disabled:.*/--disabled: $DISABLED_CSS/" "$WAYBAR_CONFIG"
fi

# Hyprland
HYPR_CONFIG="$CONFIG_DIR/hypr/hyprland.conf"
if [ -f "$HYPR_CONFIG" ]; then
    sed -i "s/^\s*col.active_border\s*=.*$/    col.active_border = $PRIMARY_HYPR/" "$HYPR_CONFIG"
    sed -i "s/^\s*col.inactive_border\s*=.*$/    col.inactive_border = $NEUTRAL_HYPR/" "$HYPR_CONFIG"
    sed -i "s/^\s*col.border_active\s*=.*$/    col.border_active = $PRIMARY_HYPR/" "$HYPR_CONFIG"
    sed -i "s/^\s*col.border_inactive\s*=.*$/    col.border_inactive = $NEUTRAL_HYPR/" "$HYPR_CONFIG"
fi

# Ly
LY_CONFIG="$CONFIG_DIR/ly/config.ini"
if [ -f "$LY_CONFIG" ]; then
    sed -i "s/^\s*cmatrix_fg\s*=.*$/cmatrix_fg = $PRIMARY_HYPR/" "$LY_CONFIG"
    sed -i "s/^\s*cmatrix_head_col\s*=.*$/cmatrix_head_col = $ACCENT_HYPR/" "$LY_CONFIG"
fi

# Btop
BTOP_CONFIG="$CONFIG_DIR/btop/config"
if [ -f "$BTOP_CONFIG" ]; then
    sed -i "s/^\s*color1\s*=.*$/color1=$PRIMARY_HYPR/" "$BTOP_CONFIG"
    sed -i "s/^\s*color2\s*=.*$/color2=$ACCENT_HYPR/" "$BTOP_CONFIG"
fi

# Mako (notifications)
MAKO_CONFIG="$CONFIG_DIR/mako/config"
if [ -f "$MAKO_CONFIG" ]; then
    sed -i "s/^\s*background\s*=.*$/background=$BACKGROUND_CSS/" "$MAKO_CONFIG"
    sed -i "s/^\s*foreground\s*=.*$/foreground=$FOREGROUND_CSS/" "$MAKO_CONFIG"
    sed -i "s/^\s*accent\s*=.*$/accent=$ACCENT_CSS/" "$MAKO_CONFIG"
fi

# Wiremix
WIREMIX_CONFIG="$CONFIG_DIR/wiremix/config.toml"
if [ -f "$WIREMIX_CONFIG" ]; then
    sed -i "s/^\s*primary\s*=.*$/primary = \"$PRIMARY_CSS\"/" "$WIREMIX_CONFIG"
    sed -i "s/^\s*accent\s*=.*$/accent = \"$ACCENT_CSS\"/" "$WIREMIX_CONFIG"
fi

# Wallpaper
WALLPAPER="$CURRENT_LINK/wpp.jpg"
if [ -f "$WALLPAPER" ]; then
    pkill swaybg
    sleep 0.1
    nohup swaybg -i "$WALLPAPER" -m fill >/dev/null 2>&1 &
fi

relaunch-apps
