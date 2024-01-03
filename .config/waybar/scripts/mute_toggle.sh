#!/bin/bash

# Find the active sink
active_sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')

# Get the current mute state of the active sink
current_mute=$(pactl list sinks | grep -A 10 "Name: $active_sink" | grep "Mute" | awk '{print $2}')

# Toggle the mute state of the active sink
if [ "$current_mute" == "yes" ]; then
    pactl set-sink-mute "$active_sink" 0  # Unmute
    echo "Unmuted $active_sink"
else
    pactl set-sink-mute "$active_sink" 1  # Mute
    echo "Muted $active_sink"
fi
