#!/bin/bash

PACMAN_UPDATES=$(checkupdates | wc -l)
AUR_UPDATES=$(yay -Qua --noconfirm | wc -l)

echo "Pacman $PACMAN_UPDATES Aur $AUR_UPDATES"

