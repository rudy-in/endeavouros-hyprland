#!/bin/bash
# script created by RedBlizard March 26 2023

kitty --hold --title "Timeshift" sudo -E env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY nohup timeshift-gtk &

