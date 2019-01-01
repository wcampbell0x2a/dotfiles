#!/bin/bash
#
# Display notification for low battery level
#
# Written by Wayne Campbell
##

main()
{
	while true
	do
		bat=$(cat /sys/class/power_supply/BAT0/capacity)
		if [[ $bat -le 50 && $bat -gt 20 ]]; then
			notify-send "Battery low warning, Battery level is ${bat}%"

		elif [[ $bat -le 20 && $bat -gt 5 ]]; then
			notify-send -u critical "Battery very low warning Battery level is ${bat}%"

		elif [[ $bat -le 5 ]]; then
			notify-send -u critical "Battery critical, please shutdown Battery level is ${bat}%"

		fi
		sleep 10m
	done
}

main
