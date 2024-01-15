#!/bin/bash

# Custom script to manage display configurations based on lid events

# Function to detect lid state
get_lid_state() {
    cat /proc/acpi/button/lid/LID0/state | awk '{print $2}'
}

# Function to configure displays when the lid is closed
configure_displays_on_lid_close() {
    # Your desired configuration when the lid is closed
    hyprctl set-monitors --output eDP-1 --off
    hyprctl set-monitors --output HDMI-A-1 --mode 1920x1080 --primary
}

# Function to configure displays when the lid is open
configure_displays_on_lid_open() {
    # Your desired configuration when the lid is open
    hyprctl set-monitors --output eDP-1 --mode 1920x1080 --primary
    hyprctl set-monitors --output HDMI-A-1 --mode 1920x1080 --right-of eDP-1
}

# Check the lid state
lid_state=$(get_lid_state)

# Act based on the lid state
if [ "$lid_state" == "closed" ]; then
    configure_displays_on_lid_close
elif [ "$lid_state" == "open" ]; then
    configure_displays_on_lid_open
fi
