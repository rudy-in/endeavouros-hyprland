#!/bin/bash

# Launch btrfs-assistant in a kitty terminal and hide the terminal window
nohup kitty sh -c 'xhost +SI:localuser:root && sudo GDK_BACKEND=x11 btrfs-assistant' > /dev/null 2>&1 &

# Wait for a moment for btrfs-assistant to start
sleep 1

# Close the terminal window
xdotool search --onlyvisible --classname "Kitty" windowactivate --sync key --clearmodifiers ctrl+shift+q
