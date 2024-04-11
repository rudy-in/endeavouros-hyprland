#!/bin/bash

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

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Set the Kvantum theme for root
ROOT_HOME=$(eval echo ~root)

THEME_NAME="Catppuccin-Frappe-Blue"

# Check if the theme exists in root's Kvantum directory
if [ ! -d "$ROOT_HOME/.Kvantum-themes/$THEME_NAME" ]; then
    echo "Error: Theme '$THEME_NAME' not found in $ROOT_HOME/.Kvantum-themes directory."
    exit 1
fi

# Check if the flag file exists
FLAG_FILE="$HOME/.config/hypr/scripts/execution_flag"

if [ ! -e "$FLAG_FILE" ]; then
    # Run scripts for the first time

    echo "Running scripts for the first time..."

    # Set the theme
    echo "Setting Kvantum theme for root to $THEME_NAME..."
    cp -R "$ROOT_HOME/.Kvantum-themes/$THEME_NAME" "$ROOT_HOME/.config/Kvantum/"
    sed -i "s/^Theme=.*/Theme=$THEME_NAME/" "$ROOT_HOME/.config/Kvantum/kvantum.kvconfig"
    echo "Theme set successfully."

    # Create the flag file to prevent future runs
    touch "$FLAG_FILE"
else
    echo "Scripts have already been executed. Exiting."
fi

exit 0
