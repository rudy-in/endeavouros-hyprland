#!/usr/bin/env bash
username="$USER"
cd endeavouros-hyprland
PACKAGES=(
    btop
    cava
    wofi
    waybar
    neofetch
    swaylock
    ttf-font-awesome
    awesome-terminal-fonts
    otf-font-awesome
    swayidle
    hyprland
    wlogout
    swww
    kitty
    qt5ct
    thunar
    thunar-archive-plugin
    thunar-volman
    sddm
    eos-sddm-theme
    xdg-desktop-portal-hyprland
    xed
    mpv
    xdg-desktop-portal
)

# Install packages
sudo pacman -S --noconfirm "${PACKAGES[@]}"

echo "Installation complete."
cp -R .config /home/$username/
chmod +x /home/$username/.config/hypr/scripts
chmod +x /home/$username/.config/hypr/scripts/*.sh
ln -s /home/$username/.config/waybar/conf/w1-config-desktop.jsonc /home/$username/.config/waybar/config.jsonc
ln -s /home/$username/.config/waybar/style/w1-style.css /home/$username/.config/waybar/style.css
ln -s /home/$username/.config/waybar/conf/w2-config-laptop.jsonc /home/$username/.config/waybar/config.jsonc
ln -s /home/$username/.config/waybar/style/w2-style.css /home/$username/.config/waybar/style.css
cp -R .local /home/$username/
cp -R .icons /home/$username/
cd ..
rm -rf endeavouros-hyprland
chown -R $username:$username /home/$username
rm hypr_packages.list
clear
echo "Installation complete Welcome to your new destiny!"
cd /

sleep 30 
reboot
