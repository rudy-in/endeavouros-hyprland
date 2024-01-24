#!/bin/bash

CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/style.css"

entries=("⭮  Reboot" "⇠  Logout" "  Lock" "⏻  Shutdown" "⏾  Suspend")

selected=$(printf "%s\n" "${entries[@]}" | wofi --dmenu --hide_search=true --prompt=Choose... --term=kitty --width=600 --columns 1 -I -s ~/.config/wofi/style.css)

if [ -n "$selected" ]; then
    case "$selected" in
        *"Reboot")
            systemctl reboot
            ;;
        *"Shutdown")
            systemctl poweroff
            ;;
        *"Logout")
            hyprctl dispatch exit 0 && hyprctl exec swaymsg exec /usr/bin/sddm-greeter
            ;;
        *"Suspend")
            systemctl suspend
            ;;
        *"Lock")
            eval "$HOME/.config/hypr/scripts/lock.sh"
            ;;
        *)
            echo "Invalid action: $selected"
            exit 1
            ;;
    esac
else
    pkill wofi
fi
