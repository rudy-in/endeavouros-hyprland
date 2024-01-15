#!/bin/bash

# Function to create a temperature graph
create_graph() {
    temp=$(echo "$1" | sed "s/  / /g") # Remove double spaces
    graph="▁""▂""▃""▄""▅""▆""▇""█"  
    for t in $temp; do
        if [ "$t" = "" ]; then continue; fi # Skip empty values
        if [ 1 -eq "$(echo "$t > 70 " | bc)" ]; then
            graph+="🌡"
        else
            graph+=""
        fi
    done
    echo "$graph"
}

# Get the temperatures
temp=$(sensors | grep "Tctl" | sed "s/Tctl: *+//;s/°C  *//" )

# Get the maximum temperature
max_temp=$(echo "$temp" | sort -nr | head -n1)

# Print the temperature and the graph
if [ 1 -eq "$(echo "$max_temp > 70 " | bc)" ]; then
    printf "<span color='#FD807E'>️🌡 $max_temp°C</span>"
elif [ 1 -eq "$(echo "$max_temp > 50 " | bc)" ]; then
    printf "<span color='#f5a97f'>🌡 $max_temp°C</span>"
else
    printf "<span color='#85C1DC'>️🌡 $max_temp°C</span>"
fi


# Show the temperature and the graph in a notification
if [ "$1" = "--popup" ]; then
    graph=$(create_graph "$temp")
    notify-send -u low -a CPU -i /usr/share/icons/Papirus-Dark/16x16/status/:/usr/share/icons/Papirus-Dark/16x16/devices/:/usr/share/icons/Papirus-Dark/16x16/actions/:/usr/share/icons/Papirus-Dark/16x16/animations/:/usr/share/icons/Papirus-Dark/16x16/apps/:/usr/share/icons/Papirus-Dark/16x16/categories/:/usr/share/icons/Papirus-Dark/16x16/emblems/:/usr/share/icons/Papirus-Dark/16x16/emotes/:/usr/share/icons/Papirus-Dark/16x16/devices/mimetypes:/usr/share/icons/Papirus-Dark/16x16/panel/:/usr/share/icons/Papirus-Dark/16x16/places/cpu.png "CPU Temperature" "Temperature:\n$temp\n"
fi

