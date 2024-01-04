#!/bin/bash

# Define the directories
dir1="$HOME/.config/hypr/scripts"
dir2="$HOME/.config/waybar/scripts"
dir3="$HOME/.config/dunst/reload"

# Function to chmod scripts in a directory
chmod_scripts() {
    local dir="$1"
    if [ -d "$dir" ]; then
        echo "Changing permissions for scripts in $dir"
        find "$dir" -type f -iname "*.sh" -exec chmod +x {} \;
        echo "Permissions changed successfully."
    else
        echo "Directory $dir does not exist."
    fi
}

# Call the function for each directory
chmod_scripts "$dir1"
chmod_scripts "$dir2"
chmod_scripts "$dir3"
