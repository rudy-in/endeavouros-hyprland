#!/bin/sh


# List of available Waybar configurations
WAYBAR_CONFIGS=("Desktop" "Laptop")


# Use wofi to present the user with a menu
selected_config=$(printf "%s\n" "${WAYBAR_CONFIGS[@]}" |wofi --dmenu --prompt=Choose... --term=kitty --width=600 --columns 1 -I -s --conf --style ~/.config/wofi/style.css)


# Define the paths for the desktop and laptop configurations
DESKTOP_CONFIG_PATH=~/.config/waybar/conf/w1-config-desktop.jsonc
LAPTOP_CONFIG_PATH=~/.config/waybar/conf/w2-config-laptop.jsonc

# Define the paths for the desktop and laptop styles
DESKTOP_STYLE_PATH=~/.config/waybar/style/w1-style.css
LAPTOP_STYLE_PATH=~/.config/waybar/style/w2-style.css

# Update the Waybar configuration based on the user's selection
case $selected_config in
  "Desktop")
    ln -sf "$DESKTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
    ln -sf "$DESKTOP_STYLE_PATH" ~/.config/waybar/style.css
    ;;
  "Laptop")
    ln -sf "$LAPTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
    ln -sf "$LAPTOP_STYLE_PATH" ~/.config/waybar/style.css
    ;;
  *)
    echo "Invalid selection."
    exit 1
    ;;
esac

# this switches the wallpaper when you swicth from laptop to desktop and from desktop to laptop
DIR=$HOME/Pictures/wallpapers-redblizard/
PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi

swww query || swww init

#change-wallpaper using swww
swww img ${DIR}/${RANDOMPICS} --transition-step 20 --transition-fps=20 

# Terminate already running bar instances

killall -q waybar

# Wait until the waybar processes have been shut down

while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main

waybar
