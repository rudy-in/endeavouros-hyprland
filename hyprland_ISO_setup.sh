#!/usr/bin/env bash
username="$USER"
cd endeavouros-hyprland
PACKAGES=(
    btop
    htop
    cava
    glances
    git
    wofi
    waybar
    fastfetch
    network-manager-applet
    networkmanager-dmenu-bluetoothfix-git
    swaylock    
    awesome-terminal-fonts
    nwg-look-bin       
    swayidle
    hyprland
    wlogout
    swww
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

# --------------------------------------------------
# Install a browser
# --------------------------------------------------

echo "Select a browser to install:"
echo "1. Chromium"
echo "2. Firefox"
echo "3. Brave"
echo "4. Microsoft Edge"

read -p "Enter the number corresponding to your choice: " choice

case $choice in
    1)
        browser="chromium"
        ;;
    2)
        browser="firefox"
        ;;
    3)
        browser="brave-bin"
        ;;
    4)
        browser="microsoft-edge-dev-bin"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Installing $browser..."
yay -S $browser

echo "Installation complete!"

# --------------------------------------------------
# Install a terminal
# --------------------------------------------------

echo "Select a terminal to install:"
echo "1. Alacritty"
echo "2. Kitty"


read -p "Enter the number corresponding to your choice: " choice

case $choice in
    1)
        terminal="alacritty"
        ;;
    2)
        terminal="kitty"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Installing $terminal..."
yay -S $terminal

echo "Installation complete!"


# ------------------------------------------------------
# Install nwg-look-bin
# ------------------------------------------------------
if yay -S --noconfirm nwg-look-bin; then
    echo "nwg-look-bin successfully installed."
    echo "Installation complete."
fi

# ------------------------------------------------------
# Install networkmanager-dmenu-bluetoothfix-git
# ------------------------------------------------------
if yay -S --noconfirm networkmanager-dmenu-bluetoothfix-git; then
    echo "nwg-look-bin successfully installed."
    echo "Installation complete."
fi

# ------------------------------------------------------
# Copying of main configs
# ------------------------------------------------------

# Backup and copy .config folder

folders=("alacritty" "btop" "cava" "dunst" "hypr" "kitty" "fastfetch" "networkmanager-dmenu" "qt5ct" "sddm-config-editor" "swaylock" "Thunar" "waybar" "wlogout" "wofi" "xsettingsd" "gtk-3.0")

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

# ----------------------------------
#       for neovim setup
# ----------------------------------
function install_neovim() {
    echo "Do you want NeoVim as text-editor:"
    echo "1. Yes"
    echo "2. No"

    read -p "Enter the number corresponding to your choice: " response

    case $response in
        1)
            nvim="neovim"
            ;;
        2)
            echo "Exiting."
            return 1
            ;;
        *)
            echo "Invalid choice. Exiting."
            return 1
            ;;
    esac

    yay -S $nvim
    git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
    echo "REMINDER : After reboot open terminal and type nvim for post installation of neovim"
}
install_neovim
# -------------------------------------

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