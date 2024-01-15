#!/bin/bash

# network_traffic.sh NETWORK_INTERFACE [POLLING_INTERVAL]

iface=${1:-lo}
isecs=${2:-1}

# `snore` adapted from https://blog.dhampir.no/content/sleeping-without-a-subprocess-in-bash-and-how-to-sleep-forever
# without MacOS workaround, TODO: with _snore_fd initialized separatedly, also i dont touch IFS so dont bother with it
snore() {
    local IFS
    [[ -n "${_snore_fd:-}" ]] || { exec {_snore_fd}<> <(:); } 2>/dev/null
    read ${1:+-t "$1"} -u $_snore_fd || :
}

# `human_readable` adapted from https://gist.github.com/cjsewell/96463db7fec6faeab291
human_readable() {
  local value=$1
  local units=( B K M G T P )
  local index=0
  while (( value > 1000 && index < 5 )); do
        (( value /= 1000, index++ ))
  done
  echo "$value${units[$index]}"
}

# sanity checking, timing here is not an issue anymore -- TODO: check how waybar reacts to `exit 1`
test -n "${iface}" && grep -q "${iface}:" /proc/net/dev || { printf '%s not found\n' "${iface}"; exit 1; }
test "$isecs" -gt 0                                     || { printf '%s not valid\n' "${isecs}"; exit 1; }

# NOTE: `/proc/net/dev` format is:
#       RX  bytes packets errs drop fifo  frame compressed multicast
#       TX  bytes packets errs drop fifo  colls carrier compressed

declare -a traffic_prev traffic_curr traffic_delta
# NOTE: array items are:
# 0=rx_bytes 1=rx_packets 2=rx_errs 3=rx_drop
# 4=tx_bytes 5=tx_packets 6=tx_errs 7=tx_drop

# TODO: rearrange the loop, do not show bogus on first iteration
traffic_prev=( 0 0 0 0  0 0 0 0 )
while snore ${isecs} ;do
  traffic_curr=( $(awk '/^ *'${iface}':/{print $2 " " $3 " " $4 " " $5 " " $10 " " $11 " " $12 " " $13}' /proc/net/dev) )
  for i in {0..7}; do
    (( traffic_delta[i] = ( traffic_curr[i] - traffic_prev[i] ) / isecs ))
  done
  # Verwijder JSON-opmaaktekens en toon alleen de tekst
  printf '⇣ %5s ⇡ %5s\n' $(human_readable ${traffic_delta[0]}) $(human_readable ${traffic_delta[4]})
  #printf '⇣ %s KB ⇡ %s KB\n' "$(human_readable "${traffic_delta[0]}")" "$(human_readable "${traffic_delta[4]}")"
  traffic_prev=(${traffic_curr[@]})
done

# TODO: handle errors
# TODO: aggregate interfaces (default to all from `ls /sys/class/net | grep -E '^(eth|wlan|enp|wlp)'`)
# TODO: tooltip with details per each interface
# TODO: colors (?)
# TODO: styling (in waybar .css, using {percent})
# TODO: unicode meter (" ","▁","▁","▂","▃","▄","▅","▆","▇","█")
# TODO: split rx/tx (?)
# TODO: test and optimize

# NOTE: in waybar config (do NOT use "interval"):
#         "custom/network_traffic": {
#             "exec": "~/.config/waybar/scripts/network_traffic.sh enp3s0",
#         },
