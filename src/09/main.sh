#!/bin/bash

if [[ $# != 0 ]]
    then
    echo "Extra parameters are specified"
else
    while true; 
    do
        if [[ -f /var/www/html/metrics/index.html]]
        then
            rm /var/www/html/metrics/index.html
        fi
        cpu="$(cat /proc/loadavg | awk '{print $1}')"
        space_all="$(df /| grep / | awk '{print $2}')"
        space_used="$(df /| grep / | awk '{print $3}')"
        memory="$(free | grep Mem | awk '{print $2}')"
        memory_used="$(free | grep Mem | awk '{print $3}')"

        echo "cpu $cpu" >> /var/www/html/metrics/index.html
        echo "space all $space_all" >> /var/www/html/metrics/index.html
        echo "space_used $space_used" >> /var/www/html/metrics/index.html
        echo "memory $memory" >> /var/www/html/metrics/index.html
        echo "memory_used $memory_used" >> /var/www/html/metrics/index.html

        sleep 5
    done
fi