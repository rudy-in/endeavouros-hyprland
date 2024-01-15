#!/bin/bash

# Function to create a CPU usage graph
create_graph() {
    usage=$(echo "$1" | sed "s/  / /g") # Remove double spaces
    graph= 
    for u in $usage; do
        if [ "$u" = "" ]; then continue; fi # Skip empty values
        bar=$(echo "$u/10" | bc | awk '{printf "%.0f", $1}') # Convert usage to a number between 0 and 8
        graph+="${graph:$bar:1}"
    done
    echo "$graph"
}

case "$1" in
    --popup)
        top_procs=$(ps axch -o cmd:10,pcpu k -pcpu | head -n 11 | awk '$0=$0"%"')
        top_procs_with_graph=""
        while read -r line; do
            process_name=$(echo "$line" | awk '{print $1}')
            process_cpu=$(echo "$line" | awk '{print $2}')
            process_graph=$(create_graph "$process_cpu")
            top_procs_with_graph+="<b>$process_name</b> - $process_cpu $process_graph\n"
        done <<< "$top_procs"
        notify-send -u low -a CPU -i /usr/share/icons/gnome/48x48/devices/cpu.png "CPU time (%)" "$top_procs_with_graph"
        ;;
    *)
        cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.2f%%\n", usage}')
        cpu_usage_per_core=$(php -r "echo round($cpu_usage / $(nproc), 2);")
        
        # Create the CPU usage graph
        graph=$(create_graph "$cpu_usage_per_core")

        # Print the CPU usage and the graph
        printf "<span color='#F3A3BC'>$cpu_usage_per_core% $graph</span>"

        # Show the CPU usage and the graph in a notification
        if [ "$1" != "--no-popup" ]; then
            notify-send -u low -a CPU -i /usr/share/icons/gnome/48x48/devices/cpu.png "CPU usage per core" "Usage:\n$cpu_usage_per_core%\n\nGraph:\n$graph"
        fi
        ;;
esac
