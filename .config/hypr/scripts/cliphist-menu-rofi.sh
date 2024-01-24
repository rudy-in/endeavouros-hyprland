#!/bin/bash
# ~/.config/hypr/scripts/cliphist-menu-rofi.sh

options=("Copy" "Delete" "Clear")
selected_option=$(echo -e "${options[@]}" | rofi -dmenu -p "Clipboard:" -mesg "Choose an action:")

theme_path=~/.config/rofi/cliphist.rasi

case $selected_option in
    "Copy")
        cliphist list | rofi -dmenu -theme $theme_path | cliphist decode | wl-copy
        ;;
    "Delete")
        cliphist list | rofi -dmenu -theme $theme_path | cliphist delete
        ;;
    "Clear")
        if [ "$(echo -e "Yes\nNo" | rofi -dmenu -theme $theme_path -p "Clear Clipboard History?")" == "Yes" ]; then
            cliphist wipe
        fi
        ;;
    *)
        echo "Invalid option"
        ;;
esac
