#!/bin/bash
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal
#sudo systemctl mask xdg-desktop-portal.service  # this disables the xdg-desktop-portal service
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &

exec Hyprland

exec Hyprland &> /tmp/hyprland-$(date +%Y-%m-%d-%H-%M-%S).log



