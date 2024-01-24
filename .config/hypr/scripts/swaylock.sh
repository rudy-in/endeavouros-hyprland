#!/bin/bash

#!/usr/bin/env bash

swaylock \
  --indicator-radius=167 \
  --indicator-thickness=23 \
  --inside-color 2e344098 \
  --inside-clear-color  2e344098 \
  --inside-ver-color 5e81ac \
  --inside-wrong-color FD807E \
  --ring-color A24D6A \
  --ring-clear-color eb6f92 \
  --ring-wrong-color eb6f92 \
  --ring-ver-color eb6f92 \
  --line-uses-ring \
  --line-color 00000000 \
  --font 'NotoSans Nerd Font Mono:style=Thin,Regular 40' \
  --layout-text-color eceff4 \
  --text-color d8dee9 \
  --text-clear-color d8dee9 \
  --text-wrong-color d8dee9 \
  --text-ver-color d8dee9 \
  --separator-color 00000000 \
  --image "$HOME/.config/hypr/swaylock.png" \
  --daemonize
