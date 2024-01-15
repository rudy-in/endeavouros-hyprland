#!/bin/sh
printf "<span font='9'></span> "
free -h  |  grep Mem: | awk '{print $3"B"}' | awk '{print substr($0, 0, length($0)-3) " " substr($0, length($0)-2, length($0)) }'

 

