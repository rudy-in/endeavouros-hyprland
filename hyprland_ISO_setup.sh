#!/usr/bin/env bash
username="$USER"
cd endeavouros-hyprland
PACKAGES=(
    alacritty
    btop
    htop
    brave-bin
    cava
    glances
    git
    wofi
    waybar
    neofetch
    swaylock-effects-git
    ttf-font-awesome
    awesome-terminal-fonts
    nwg-look
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
    yay
)

# ---------------------
# Set the log file path
# ---------------------
log_file="$HOME/installation_log.txt"

# --------------------------------------------------
# Redirect stdout (1) and stderr (2) to the log file
# --------------------------------------------------
exec > >(tee -i "$log_file") 2>&1

# Function to backup a file or directory
backup() {
    local item="$1"
    local backup_dir="$item.back"

    # If .back already exists, find the next available numeric suffix
    suffix=1
    while [ -e "$backup_dir$suffix" ]; do
        ((suffix++))
    done

    mv "$item" "$backup_dir$suffix"
}

# Install packages
sudo pacman -S --noconfirm "${PACKAGES[@]}"

# ------------------------------------------------------
# Install brave
# ------------------------------------------------------
if yay -S --noconfirm brave-bin; then
    echo "Brave successfully installed."

    # Check if brave is in the PATH
    if command -v brave &> /dev/null; then
        # Set Brave as the default browser
        echo "export BROWSER=brave" | sudo tee -a /etc/environment
        xdg-settings set default-web-browser brave.desktop
        echo "Brave set as the default browser."
    else
        echo "Error: Brave not found in the PATH."
    fi
else
    echo "Error: Failed to install Brave."
fi

# ------------------------------------------------------
# Install swaylock-effects-git
# ------------------------------------------------------
if yay -S --noconfirm swaylock-effects-git; then
    echo "swaylock-effects-git successfully installed."
    echo "Installation complete."
fi

# ------------------------------------------------------
# Copying of main configs
# ------------------------------------------------------

# Backup and copy .config folder

folders=("alacritty" "btop" "cava" "dunst" "hypr" "kitty" "neofetch" "networkmanager-dmenu" "qt5ct" "sddm-config-editor" "swaylock" "Thunar" "waybar" "wlogout" "wofi" "xsettingsd" "gtk-3.0")

for folder in "${folders[@]}"; do
    folder_path="/home/$username/.config/$folder"
    backup "$folder_path"
done

cp -R .config /home/$username/

# Backup and copy .local and .icons folders
backup "/home/$username/.local"
cp -R .local /home/$username/

backup "/home/$username/.icons"
cp -R .icons /home/$username/    

echo "Installation complete."
chmod +x /home/$username/.config/hypr/scripts
chmod +x /home/$username/.config/hypr/scripts/*.sh
ln -s /home/$username/.config/waybar/conf/w1-config-desktop.jsonc /home/$username/.config/waybar/config.jsonc
ln -s /home/$username/.config/waybar/style/w1-style.css /home/$username/.config/waybar/style.css
ln -s /home/$username/.config/waybar/conf/w2-config-laptop.jsonc /home/$username/.config/waybar/config.jsonc
ln -s /home/$username/.config/waybar/style/w2-style.css /home/$username/.config/waybar/style.css
ln -s ~/Pictures/wallpapers-redblizard/ ~/.wallpapers
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
