#!/bin/bash
# ~/.config/hypr/scripts/cliphist-menu.sh

options=("Copy" "Delete" "Clear")
selected_option=$(printf "%s\n" "${options[@]}" | wofi -dmenu -p "Clipboard:")

case $selected_option in
    "Copy")
        cliphist list | wofi -dmenu | cliphist decode | wl-copy
        ;;
    "Delete")
        cliphist list | wofi -dmenu | cliphist delete
        ;;
    "Clear")
        if [ "$(echo -e "Yes\nNo" | wofi -dmenu -p "Clear Clipboard History?")" == "Yes" ]; then
            cliphist wipe
        fi
        ;;
    *)
        echo "Invalid option"
        ;;
esac
