#!/bin/sh

# set the gtk-theme / icon-theme and cursor-theme for root
if [ $XDG_CONFIG_HOME ]
set config "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
else
set config "./$HOME/.config/gtk-3.0/settings.ini"
end

if [ ! -f "$config" ]
exit 1
end

gnome_schema="org.gnome.desktop.interface"
gtk_theme="$(grep 'gtk-theme-name' "$config" | cut -d'=' -f2)"
icon_theme="$(grep 'gtk-icon-theme-name' "$config" | cut -d'=' -f2)"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | cut -d'=' -f2)"
font_name="$(grep 'gtk-font-name' "$config" | cut -d'=' -f2)"
gsettings set $gnome_schema gtk-theme 'Catppuccin-Frappe-Standard-Blue-Dark'
gsettings set $gnome_schema icon-theme 'Papirus-Dark'
gsettings set $gnome_schema cursor-theme 'Qogir-dark'
gsettings set $gnome_schema font-name 'Noto Sans 10'
set -e config gtk_theme gnome_schema icon_theme cursor_theme font_name

# Change Papirus folder colors
papirus-folders -C cat-frappe-blue --theme Papirus-Dark

