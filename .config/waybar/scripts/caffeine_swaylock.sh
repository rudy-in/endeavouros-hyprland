#!/bin/bash

if pgrep -x "swayidle" > /dev/null; then
   # Caffeine is enabled, so disable it
   killall swayidle
   # Update the Waybar module to display the empty coffee cup icon immediately
   echo '{"text": ""}' > /tmp/waybar_caffeine_fifo
else
   # Caffeine is disabled, so enable it
   swayidle -w \
       before-sleep "swaylock" \
       timeout 160 'temp=$(brightnessctl g); brightnessctl set $((temp / 2))' \
           resume 'temp=$(brightnessctl g); brightnessctl set $((temp * 2))' \
       timeout 120 "swaylock" \
           resume 'hyprctl dispatch dpms on' &
   # Update the Waybar module to display the full coffee cup icon immediately
   echo '{"text": "﯈"}' > /tmp/waybar_caffeine_fifo
fi
