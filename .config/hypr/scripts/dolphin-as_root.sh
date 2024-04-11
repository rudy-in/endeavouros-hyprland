#!/bin/bash

# Launch Dolphin as root using pkexec
xhost +si:localuser:root && pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY KDE_SESSION_VERSION=5 KDE_FULL_SESSION=true dbus-launch dolphin 

# Wait for a moment for Polkit to prompt for authentication
sleep 10

# Close the terminal window
xdotool search --onlyvisible --classname "Kitty" windowactivate --sync key --clearmodifiers ctrl+shift+q
