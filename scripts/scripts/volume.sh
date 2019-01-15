#!/bin/bash

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function display_change {
    volume=`get_volume`

    bar_num=$(($volume / 5))
    spaces_num=$((20 - ($volume / 5)))

    bar=$(seq -s "─" $bar_num | sed 's/[0-9]//g')
    spaces=$(printf "%*s%s" $spaces_num)

    # Send the notification
    notify-send "Volume: |$bar$spaces|" -t "600"
}

curr_vol=`get_volume`
while true
do
	new_vol=`get_volume`
	if [ "$curr_vol" != "$new_vol" ]; then
		curr_vol="$new_vol"
		display_change
	fi
done
