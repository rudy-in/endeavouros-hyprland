#!/bin/bash

while true; do
    main_menu="1. Hyprland\n2. Waybar configs\n3. Waybar styles\n4. Swww options"
    selected_config=$(echo -e "$main_menu" | wofi --dmenu --hide_search=true --prompt=Choose... --term=kitty --width=600 --columns 1 -I -s ~/.config/wofi/style.css)
    
    # Check if the escape key was pressed
    if [ "$selected_config" == "" ]; then
        echo "Escape key pressed. Exiting script."
        break
    fi
    
    echo "Selected: $selected_config"

case $selected_config in
    "1. Hyprland")
        submenu=$(echo -e "0. Back to main menu\n1. ~/.config/hypr/hyprland.conf\n2. ~/.config/hypr/conf/env_var.conf\n3. ~/.config/hypr/conf/monitor.conf\n4. ~/.config/hypr/conf/workspaces.conf\n5. ~/.config/hypr/conf/key_binds.conf\n6. ~/.config/hypr/conf/window_binds.conf\n7. ~/.config/hypr/conf/window_rules.conf" | wofi --dmenu --hide_search=true --prompt=Choose... --term=kitty --width=600 --columns 1 -I -s ~/.config/wofi/style.css)
        echo "Selected submenu: $submenu"
        case $submenu in
            "0. Back to main menu")
                echo "Going back to the main menu" ;;
            "1. ~/.config/hypr/hyprland.conf")
                echo "Launching nano for hyprland.conf"
                kitty nano ~/.config/hypr/hyprland.conf ;;
            "2. ~/.config/hypr/conf/env_var.conf")
                echo "Launching nano for env_var.conf"
                kitty nano ~/.config/hypr/conf/env_var.conf ;;
            "3. ~/.config/hypr/conf/monitor.conf")
                echo "Launching nano for monitor.conf"
                kitty nano ~/.config/hypr/conf/monitor.conf ;;
            "4. ~/.config/hypr/conf/workspaces.conf")
                echo "Launching nano for workspaces.conf"
                kitty nano ~/.config/hypr/conf/workspaces.conf ;;
            "5. ~/.config/hypr/conf/key_binds.conf")
                echo "Launching nano for key_binds.conf"
                kitty nano ~/.config/hypr/conf/key_binds.conf ;;
            "6. ~/.config/hypr/conf/window_binds.conf")
                echo "Launching nano for window_binds.conf"
                kitty nano ~/.config/hypr/conf/window_binds.conf ;;                
            "7. ~/.config/hypr/conf/window_rules.conf")
                echo "Launching nano for window_rules.conf"
                kitty nano ~/.config/hypr/conf/window_rules.conf ;;
            *)
                echo "Invalid submenu selection: $submenu" ;;
        esac
            ;;
        "2. Waybar configs")
            submenu=$(echo -e "0. Back to main menu\n1. ~/.config/waybar/conf/w1-config-desktop.jsonc\n2. ~/.config/waybar/conf/w2-config-laptop.jsonc" | wofi --dmenu --hide_search=true --prompt=Choose... --term=kitty --width=600 --columns 1 -I -s ~/.config/wofi/style.css)
            echo "Selected submenu: $submenu"
            case $submenu in
                "0. Back to main menu")
                    echo "Going back to the main menu" ;;
                "1. ~/.config/waybar/conf/w1-config-desktop.jsonc")
                    echo "Launching nano for w1-config-desktop.jsonc"
                    kitty nano ~/.config/waybar/conf/w1-config-desktop.jsonc ;;
                "2. ~/.config/waybar/conf/w2-config-laptop.jsonc")
                    echo "Launching nano for w2-config-laptop.jsonc"
                    kitty nano ~/.config/waybar/conf/w2-config-laptop.jsonc ;;
                *)
                    echo "Invalid submenu selection: $submenu" ;;
            esac
            ;;
        "3. Waybar styles")
            submenu=$(echo -e "0. Back to main menu\n1. ~/.config/waybar/style/w1-style.css\n2. ~/.config/waybar/style/w2-style.css" | wofi --dmenu --hide_search=true --prompt=Choose... --term=kitty --width=600 --columns 1 -I -s ~/.config/wofi/style.css)
            echo "Selected submenu: $submenu"
            case $submenu in
                "0. Back to main menu")
                    echo "Going back to the main menu" ;;
                "1. ~/.config/waybar/style/w1-style.css")
                    echo "Launching nano for w1-style.css"
                    kitty nano ~/.config/waybar/style/w1-style.css ;;
                "2. ~/.config/waybar/style/w2-style.css")
                    echo "Launching nano for w2-style.css"
                    kitty nano ~/.config/waybar/style/w2-style.css ;;
                *)
                    echo "Invalid submenu selection: $submenu" ;;
            esac
            ;;
        "4. Swww options")
            submenu=$(echo -e "0. Back to main menu\n1. Kill swww\n2. Change Wallpaper Directory\n3. Initialize swww" | wofi --dmenu --hide_search=true --prompt=Choose... --term=kitty --width=600 --columns 1 -I -s ~/.config/wofi/style.css)
            echo "Selected submenu: $submenu"
            case $submenu in
                "0. Back to main menu")
                    echo "Going back to the main menu" ;;
                "1. Kill swww")
                     echo "Killing swww"
                     pkill swww ;;
                "2. Change Wallpaper Directory")
                    echo "Launching nano for random-wallpaper"
                    kitty nano ~/.config/hypr/scripts/random-wallpaper ;;
                "3. Initialize swww")
                    echo "Initializing swww"
                    swww init ;;
                *)
                    echo "Invalid submenu selection: $submenu" ;;
            esac
            ;;
        *)
            echo "Invalid selection: $selected_config" ;;
    esac
done



