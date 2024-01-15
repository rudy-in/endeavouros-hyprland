#!/bin/bash

layout_f="/tmp/kb_layout"
current_layout=$(cat "$layout_f")

# Define a mapping of layout codes to two-letter language codes
layout_mapping=("us" "en" "nl" "es" "de" "ru")
layout_count=${#layout_mapping[@]}

# Find the index of the current layout in the mapping
for ((i = 0; i < layout_count; i += 2)); do
  if [ "$current_layout" == "${layout_mapping[i]}" ]; then
    current_index=$i
    break
  fi
done

# Calculate the index of the next layout
next_index=$(( (current_index + 2) % layout_count ))
new_layout="${layout_mapping[next_index]}"

hyprctl keyword input:kb_layout "$new_layout"
echo "$new_layout" > "$layout_f"
