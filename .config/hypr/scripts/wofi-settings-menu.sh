#!/bin/bash

CONFIG="$HOME/.config/wofi/wofi-settings-menu/config"
STYLE="$HOME/.config/wofi/wofi-settings-menu/style.css"


if [[ ! $(pidof wofi) ]]; then
   wofi --dmenu --term=kitty --width=600 --columns 1 -I -s ~/.config/wofi/wofi-settings-menu/config --style ~/.config/wofi/wofi-settings-menu/style.css --conf ${CONFIG} --style ${STYLE} --color ${COLORS}
else
  pkill wofi
fi




