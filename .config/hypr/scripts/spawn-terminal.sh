#!/bin/bash

# Get the screen resolution and calculate the center point
SCREEN_WIDTH=$(swaymsg -t get_outputs | jq '.[] | select(.focused) | .rect.width')
SCREEN_HEIGHT=$(swaymsg -t get_outputs | jq '.[] | select(.focused) | .rect.height')
CENTER_X=$(echo "$SCREEN_WIDTH / 2" | bc)
CENTER_Y=$(echo "$SCREEN_HEIGHT / 2" | bc)

# Draw the rectangle
RECT=$(slurp)

# Parse the rectangle coordinates
X=$(echo "$RECT" | awk '{print $1}')
Y=$(echo "$RECT" | awk '{print $2}')
WIDTH=$(echo "$RECT" | awk '{print $3}')
HEIGHT=$(echo "$RECT" | awk '{print $4}')

# Calculate the position of the new kitty window
NEW_X=$(echo "$CENTER_X + $X - ($SCREEN_WIDTH / 2)" | bc)
NEW_Y=$(echo "$CENTER_Y + $Y - ($SCREEN_HEIGHT / 2)" | bc)

# Spawn a new kitty window and move and resize it to fit the rectangle
# example setting terminal spawn size : xfce4-terminal --geometry=600x400 &
kitty --title kitty_floats &
sleep 0.5
WINDOW_ID=$(xdotool search --sync --onlyvisible --name "kitty")
xdotool windowmove "$WINDOW_ID" "$NEW_X" "$NEW_Y"
xdotool windowsize "$WINDOW_ID" "$WIDTH" "$HEIGHT"
