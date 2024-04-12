#!/bin/bash

# Check if Nvidia GPU is being used
if lspci | grep -i nvidia &> /dev/null; then
    # Check if the execution flag file exists
    if [ ! -f "/tmp/nvidia_setup_executed.flag" ]; then
        # Uncomment Nvidia-specific settings
        sed -i 's/^#env = LIBVA_DRIVER_NAME,nvidia/env = LIBVA_DRIVER_NAME,nvidia/' hyprland.conf
        sed -i 's/^#env = XDG_SESSION_TYPE,wayland/env = XDG_SESSION_TYPE,wayland/' hyprland.conf
        sed -i 's/^#env = GBM_BACKEND,nvidia-drm/env = GBM_BACKEND,nvidia-drm/' hyprland.conf
        sed -i 's/^#env = __GLX_VENDOR_LIBRARY_NAME,nvidia/env = __GLX_VENDOR_LIBRARY_NAME,nvidia/' hyprland.conf

        # Comment out the WLR_NO_HARDWARE_CURSORS rule
        sed -i 's/^env = WLR_NO_HARDWARE_CURSORS,1. #/env = WLR_NO_HARDWARE_CURSORS,1 #/' hyprland.conf

        # Create the execution flag file
        touch /tmp/nvidia_setup_executed.flag

        echo "Nvidia rules applied successfully."
    else
        echo "Nvidia rules have already been applied."
    fi
else
    echo "No Nvidia GPU detected. Exiting."
fi
