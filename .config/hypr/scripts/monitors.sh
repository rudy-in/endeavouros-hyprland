#!/bin/bash

# Assign the absolute path to monitor.conf as the first command-line argument
filePath=$1

# Check if the absolute path to monitor.conf is provided as an argument
if [ $# -eq 0 ]; then
  echo "Absolute path to monitor.conf must be provided as argument."
  exit 2
fi

# Function to handle monitor events
handle() {
  cd "$(dirname "$0")"
  case $1 in
    monitoradded*) 
      echo "$1"
      # Extract monitor information from event (e.g., monitor name)
      monitor=$(echo "$1" | cut -d ' ' -f 2)
      # Check if the monitor is the third monitor
      if [ "$monitor" == "HDMI-A-1" ]; then
        # Set settings for the third monitor
        echo "monitor = $monitor,1920x1080@60.000,1920x0,1" >> "$filePath"
      else
        # Set settings for other monitors
        echo "monitor = $monitor,1920x1080@60.000,0x0,1" >> "$filePath"
      fi
      ;;
    monitorremoved*) 
      echo "$1"
      # Extract monitor information from event (e.g., monitor name)
      monitor=$(echo "$1" | cut -d ' ' -f 2)
      # Check if the monitor is the third monitor
      if [ "$monitor" == "HDMI-A-1" ]; then
        # Remove settings for the third monitor
        sed -i "/^monitor = $monitor/d" "$filePath"
      else
        # Remove settings for other monitors
        sed -i "/^monitor = $monitor/d" "$filePath"
      fi
      ;;
  esac
}

# Call handle function with initial monitoradded event
handle "monitoradded";

# Listen for monitor events and call handle function for each event
socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
