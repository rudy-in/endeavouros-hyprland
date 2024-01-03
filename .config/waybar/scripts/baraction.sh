#!/bin/sh

# Check the current Waybar configuration path
CURRENT_CONFIG=$(readlink -f ~/.config/waybar/config.jsonc)

# Define the paths for the desktop and laptop configurations
DESKTOP_CONFIG_PATH=~/.config/waybar/conf/w1-config-desktop.jsonc
LAPTOP_CONFIG_PATH=~/.config/waybar/conf/w2-config-laptop.jsonc

# Define the paths for the desktop and laptop styles
DESKTOP_STYLE_PATH=~/.config/waybar/style/w1-style.css
LAPTOP_STYLE_PATH=~/.config/waybar/style/w2-style.css

# Check the current configuration and switch to the opposite
if [ "$CURRENT_CONFIG" = "$DESKTOP_CONFIG_PATH" ]; then
    ln -sf "$LAPTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
    ln -sf "$LAPTOP_STYLE_PATH" ~/.config/waybar/style.css
else
    ln -sf "$DESKTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
    ln -sf "$DESKTOP_STYLE_PATH" ~/.config/waybar/style.css
fi

# Restart Waybar
pkill waybar
waybar &
