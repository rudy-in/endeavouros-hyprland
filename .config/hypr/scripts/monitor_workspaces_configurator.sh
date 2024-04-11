#!/bin/bash

# Define the flag file path for first-time execution
FLAG_FILE="$HOME/.config/hypr/scripts/execution_flag"

# Check if the flag file exists
if [ ! -e "$FLAG_FILE" ]; then

echo "Running scripts for the first time..."

# Clear existing configurations in both workspaces.conf and monitor.conf
echo "Clearing existing configurations..."
> ~/.config/hypr/conf/workspaces.conf
> ~/.config/hypr/conf/monitor.conf

echo "" >> ~/.config/hypr/conf/monitor.conf 
echo "#█▀▄▀█ █▀█ █▄ █ █ ▀█▀ █▀█ █▀█" > ~/.config/hypr/conf/monitor.conf
echo "#█ ▀ █ █▄█ █ ▀█ █  █  █▄█ █▀▄" >> ~/.config/hypr/conf/monitor.conf
echo "#Monitor Definitions" >> ~/.config/hypr/conf/monitor.conf
echo "" >> ~/.config/hypr/conf/monitor.conf
echo "# see the wiki https://wiki.hyprland.org/Configuring/Monitors/" >> ~/.config/hypr/conf/monitor.conf
echo "" >> ~/.config/hypr/conf/monitor.conf  

# Get monitor configurations using hyprctl monitors all
monitor_config=$(hyprctl monitors all)

# Extract monitor names from the output
mapfile -t monitor_names < <(echo "$monitor_config" | grep -oP '(?<=Monitor )\S+(?= \()')

  # Define monitor resolutions
    echo "# QEMU is Virtua-1 1920x1080@60,auto,1 " >> ~/.config/hypr/conf/monitor.conf
    echo "" >> ~/.config/hypr/conf/monitor.conf 
    declare -A resolutions=(
        ["eDP-1"]="1920x1080@60.000,0x0,1"
        ["HDMI-A-1"]="1920x1080@50.000,1920x0,1"
        ["DP-1"]="1920x1080@60.000,0x0,1"
        ["DP-2"]="1920x1080@60.000,0x0,1"
        ["DP-3"]="1920x1080@60.000,0x0,1"
        ["Virtual-1"]="1920x1080@60,auto,1"        
        ["Other-1"]="2560x1440@60.000,0x0,1"
        ["Other-2"]="3840x2160@60.000,0x0,1"
        ["Other-3"]="1280x720@60.000,0x0,1"
        ["Other-4"]="1600x900@60.000,0x0,1"
        ["Other-5"]="1366x768@60.000,0x0,1"              
    )    
    
  # Update monitor.conf with hardcoded resolutions
    echo "Updating monitor configurations..."
    echo "# Monitor Definitions" >> ~/.config/hypr/conf/monitor.conf
    for monitor in "${!resolutions[@]}"; do
        if [[ -v resolutions["$monitor"] ]]; then
            if [[ "${USER}" == "Rudy-in" && "$monitor" == "eDP-1" ]]; then
                echo "#monitor = $monitor,${resolutions[$monitor]}" >> ~/.config/hypr/conf/monitor.conf
            else
                echo "monitor = $monitor,${resolutions[$monitor]}" >> ~/.config/hypr/conf/monitor.conf
            fi
        else
            echo "Warning: No resolution specified for $monitor"
        fi
    done

    # Check if the monitor is eDP-1 and set resolutions accordingly
    if [[ "${monitor_names[@]}" =~ "eDP-1" ]]; then
        if [[ "${USER}" == "Rudy-in" ]]; then
            resolutions["eDP-1"]="preferred,auto,0.85"
        else
            resolutions["eDP-1"]="1920x1080@60.000,0x0,1"
        fi
    fi

echo "" >> ~/.config/hypr/conf/monitor.conf
echo "#monitor = ,preferred,auto,1" >> ~/.config/hypr/conf/monitor.conf
echo "#monitor = ,highrr,auto,1" >> ~/.config/hypr/conf/monitor.conf
echo "#monitor = ,highres,auto,1" >> ~/.config/hypr/conf/monitor.conf
echo "" >> ~/.config/hypr/conf/monitor.conf
    if [[ "${USER}" == "Rudy-in" ]]; then
        echo "#dev Rudy-in uses these settings" >> ~/.config/hypr/conf/monitor.conf
        echo "#monitor = ,preferred,auto,0.85" >> ~/.config/hypr/conf/monitor.conf
        echo "#monitor = ,highres,auto,0.85" >> ~/.config/hypr/conf/monitor.conf
        echo "#env = GDK_SCALE,0.85" >> ~/.config/hypr/conf/monitor.conf
    else
        echo "#dev Rudy-in uses these settings" >> ~/.config/hypr/conf/monitor.conf
        echo "#monitor = ,preferred,auto,0.85" >> ~/.config/hypr/conf/monitor.conf
        echo "#monitor = ,highres,auto,0.85" >> ~/.config/hypr/conf/monitor.conf
        echo "#env = GDK_SCALE,0.85" >> ~/.config/hypr/conf/monitor.conf
    fi
echo "" >> ~/.config/hypr/conf/monitor.conf
echo "#Transform list:" >> ~/.config/hypr/conf/monitor.conf
echo "#normal (no transforms) -> 0" >> ~/.config/hypr/conf/monitor.conf
echo "#90 degrees -> 1" >> ~/.config/hypr/conf/monitor.conf
echo "#180 degrees -> 2" >> ~/.config/hypr/conf/monitor.conf
echo "#270 degrees -> 3" >> ~/.config/hypr/conf/monitor.conf
echo "#flipped -> 4" >> ~/.config/hypr/conf/monitor.conf
echo "#flipped + 90 degrees -> 5" >> ~/.config/hypr/conf/monitor.conf
echo "#flipped + 180 degrees -> 6" >> ~/.config/hypr/conf/monitor.conf
echo "#flipped + 270 degrees -> 7" >> ~/.config/hypr/conf/monitor.conf

echo "" >> ~/.config/hypr/conf/workspaces.conf
echo "#█░█░█ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀ █▀" >> ~/.config/hypr/conf/workspaces.conf
echo "#▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ █▀▀ █▀█ █▄▄ ██▄ ▄█" >> ~/.config/hypr/conf/workspaces.conf
echo "# example how to set workspaces to the correct monitor" >> ~/.config/hypr/conf/workspaces.conf
echo "" >> ~/.config/hypr/conf/workspaces.conf

# Update workspaces.conf for each monitor
echo "# Workspaces Configuration" >> ~/.config/hypr/conf/workspaces.conf
for monitor in "${monitor_names[@]}"; do
    for (( workspace=1; workspace<=10; workspace++ )); do
        echo "workspace=$workspace,monitor:$monitor" >> ~/.config/hypr/conf/workspaces.conf
    done
done

    # Create flag file to mark first-time execution
    echo "Creating flag file for first-time execution..."
    touch "$FLAG_FILE"

else
    echo "Scripts have already been executed. Exiting."
fi

# Define the flag file path for one-time execution
ONCE_FLAG_FILE="$HOME/.config/hypr/scripts/execution_once_flag"

# Check if the flag file exists
if [ ! -e "$ONCE_FLAG_FILE" ]; then
    echo "Running one-time execution tasks..."

    # Run one-time execution tasks here
    
    # Create flag file to mark one-time execution
    touch "$ONCE_FLAG_FILE"
fi
