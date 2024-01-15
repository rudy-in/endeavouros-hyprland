#!/bin/bash

# Get the current time
current_time=$(date +"%H:%M")

# Get the current date
current_date=$(date +"%a, %d %b")

# Get the current month
current_month=$(date "+%B")

# Get the current day of the month
current_day=$(date "+%d")

# Get the current week number
current_week=$(date "+%V")

# Get the current day of the week
current_day_of_week=$(date "+%A")

# Get the current year
current_year=$(date "+%Y")

# Get the current calendar data
calendar_data=$(cal | awk '{print $2}' | sed -e 's/[ ]//g')

# Parse the calendar data
padded_calendar_data=$(printf "%*s" $(tput cols) "$calendar_data")

# Format the calendar data
formatted_calendar_data=$(echo "$padded_calendar_data" | sed -e 's/{}/\u\l\l/g')

# Define the JSON object
calendar_object=$(printf '{ "text": " %s  %s", "tooltip": "<tt><small>%s, %s %s</small></tt>", "calendar": {"mode": "year", "mode-mon-col": 3, "weeks-pos": "right", "on-scroll": 1, "on-click-right": "mode", "format": {"months": "<span color='#ffead3'><b>%s</b></span>", "days": "<span color='#ecc6d9'><b>%s</b></span>", "weeks": "<span color='#A6D189'><b>W%s</b></span>", "weekdays": "<span color='#E5C890'><b>%s</b></span>", "today": "<span color='#E78284'><b><u>%s</u></b></span>"}}}")

# Output the JSON object
echo "$calendar_object"
