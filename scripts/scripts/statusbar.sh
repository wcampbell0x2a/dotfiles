#!/bin/bash
#
# Status bar for dwm
#
# Plex parser: Written by Wayne Campbell
# Bash Marque: Written by Claudio M. Alessi
##

# Interval between permutation in the current marquee
INTERVAL=.3

# Output program
PRINT="$(which xsetroot) -name"
# Debug
#PRINT="echo -ne"

#
# Get plex info from log files
#
get_plex_info(){
	user_name=$USER
  	if (pgrep -x "plexmediaplayer" > /dev/null); then
    		artist=$(grep "display-tags:  Artist" /home/$user_name/.local/share/plexmediaplayer/logs/plexmediaplayer.log | tail -1 | sed 's/.*://')
    		title=$(grep "display-tags:  Title" /home/$user_name/.local/share/plexmediaplayer/logs/plexmediaplayer.log | tail -1 | sed 's/.*://')
    		album=$(grep "display-tags:  Album" /home/$user_name/.local/share/plexmediaplayer/logs/plexmediaplayer.log | tail -1 | sed 's/.*://')
    		plex_output="$artist-$title-$album "
  	else
    		plex_output=""
  	fi
}

cpu_usage()
{
	echo $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print int(100 - $1)"%"}')
}

ram_usage()
{
	echo $(free | grep Mem | awk '{printf int($3/$2 * 100.0)"%"}')
}

lan_ip()
{
	echo $(ip -4 -o addr show dev ens20u1u4| awk '{split($4,a,"/");print a[1]}')
}

lan_wireless()
{
	echo $(ip -4 -o addr show dev wlp59s0| awk '{split($4,a,"/");print a[1]}')
}

vol_level()
{
	echo $(amixer get Master | tail -n1 | grep -Po "\\[\\K[^%]*" | head -n1)
}

format_date()
{
	echo $(date +"%D %T")
}

#
# Marquee text from left to the right
#
marquee_right()
{
	get_plex_info	
	string="$plex_output"
	let eidx=${#string}+1

	for i in $(seq 1 $eidx)
	do
		get_plex_info
		if [[ $plex_output == $string ]]; then
		{
			let j=$eidx-$i+1
			strout="$(echo "$string" | cut -b $j-)"
			let --j
			[ $j -gt 0 ] && strout="$strout$(echo "$string" | cut -b -$j)"
			$PRINT "$strout $(whoami): cpu $(cpu_usage), ram $(ram_usage), lan $(lan_ip), wlan $(lan_wireless), vol $(vol_level)%, $(format_date)"
			#Debug
			#$PRINT "$strout $(whoami): cpu $(cpu_usage), ram $(ram_usage), lan $(lan_ip), wlan $(lan_wireless), vol $(vol_level)%, $(format_date) \r "
			sleep $INTERVAL
		}
		else
		{
			echo -ne "\r\033[K"
		}
		fi
	done
}


#
# The main function
#
main()
{
	# Empty the title on exit
	for SIG in INT TERM
		do trap "$PRINT '' && exit" $SIG
	done

	while true
	do
		marquee_right
	done
}

main

