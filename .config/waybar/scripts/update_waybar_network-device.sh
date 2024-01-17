#!/bin/bash

# Function to get the active network interface
get_active_interface() {
  ip -o link show up | awk '$2 != "lo:" {print $2; exit}'
}

# Get the active network interface
active_interface=$(get_active_interface)

# Waybar configuration file path
waybar_config="$HOME/.config/waybar/conf/w1-config-desktop.jsonc"
waybar_config="$HOME/.config/waybar/conf/w2-config-laptop.jsonc"

# Find the line with the network_traffic module and update the network device
sed -i "s|\"exec\": \".*network_traffic.sh .*\"|\"exec\": \"~/.config/waybar/scripts/network_traffic.sh $active_interface\",|;s/:\",,/\",/" "$waybar_config"

# Terminate already running bar instances

killall -q waybar

# Wait until the waybar processes have been shut down

while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main

waybar
