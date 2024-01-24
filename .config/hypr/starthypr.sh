#!/bin/bash

cd ~

# Variables
export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24

sleep 4
# start hyprland
kitty -c echo "Starting Hyprland" >> /tmp/hyprland-$(date +%Y-%m-%d-%H-%M-%S).log
exec /usr/bin/Hyprland &> /tmp/hyprland-$(date +%Y-%m-%d-%H-%M-%S).log
