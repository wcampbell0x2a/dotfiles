#!/bin/bash
status=$(cat /sys/class/power_supply/BAT0/status)
while true
do
	new_status=$(cat /sys/class/power_supply/BAT0/status)
    	if [ "$status" != "$new_status" ]; then 
		if [ "$new_status" != "Unknown" ]; then
			status=$(cat /sys/class/power_supply/BAT0/status)
			notify-send "Battery Status" "Battery is $status"
		fi
    	fi
	sleep 1
done
