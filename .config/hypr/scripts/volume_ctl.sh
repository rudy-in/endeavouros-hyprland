#!/usr/bin/env bash

function get_volume {
  pactl list sources | grep -A 10 "Name: $(pacmd dump | grep "set-default-source" | awk '{print $NF}')" | grep "Volume:" | awk '{print $5}' | sed 's/[%|]//g'
}

function is_mute {
  pactl list sources | grep -A 10 "Name: $(pacmd dump | grep "set-default-source" | awk '{print $NF}')" | grep "Mute:" | grep "yes" >/dev/null
}

function send_notification {
  iconSound="audio-input-microphone"
  iconMuted="audio-input-microphone-muted"
  if is_mute ; then
    dunstify -i $iconMuted -r 2594 -u normal "Microphone Muted"
  else
    volume=$(get_volume)
    bar=$(seq --separator="─" 0 "$(((volume - 1) / 4))" | sed 's/[0-9]//g')
    space=$(seq --separator=" " 0 "$(((100 - volume) / 4))" | sed 's/[0-9]//g')
    dunstify -i $iconSound -r 2594 -u normal "|$bar$space| $volume%"
  fi
}

case $1 in
  up)
    pactl set-source-volume @DEFAULT_SOURCE@ +5%
    send_notification
    ;;
  down)
    pactl set-source-volume @DEFAULT_SOURCE@ -5%
    send_notification
    ;;
  mute)
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    send_notification
    ;;
esac
