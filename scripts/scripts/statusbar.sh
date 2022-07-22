#!/bin/bash
#
# Status bar for dwm
#
# Plex parser: Written by Wayne Campbell
# Bash Marque: Written by Claudio M. Alessi(https://github.com/itdaniher/bash-scripts-old/blob/master/marquee)
#
# Prints plex output from plexmediaplayer.log file. Parses this output into a marquee
# that was found on github. I used the logic in the sample to create my own marquee for the plex output.
# Prints out useful system info as an exercise in linux cmd line.
##

# Interval between permutation in the current marquee
INTERVAL=.3

# Output program
PRINT="$(which xsetroot) -name"
# Debug
#PRINT="echo -ne \n"

#
# Get plex info from log files
#
get_plex_info(){
	user_name=$USER
  	if (pgrep -x "plexmediaplayer" > /dev/null); then
    		artist=$(grep "display-tags:  Artist" /home/"$user_name"/.local/share/plexmediaplayer/logs/plexmediaplayer.log | tail -1 | sed 's/.*://')
    		title=$(grep "display-tags:  Title" /home/"$user_name"/.local/share/plexmediaplayer/logs/plexmediaplayer.log | tail -1 | sed 's/.*://')
    		album=$(grep "display-tags:  Album" /home/"$user_name"/.local/share/plexmediaplayer/logs/plexmediaplayer.log | tail -1 | sed 's/.*://')
		if [[ -z "$artist" || -z "$title" || -z "$album" ]]
		then
			plex_output=""
		else
    			plex_output="$artist-$title-$album "
		fi
  	else
    		plex_output=""
  	fi
}

current_bat()
{
	bat0="$(cat /sys/class/power_supply/BAT0/capacity)"
	bat1="$(cat /sys/class/power_supply/BAT1/capacity)"
	echo "bat [$bat0%,$bat1%], "
}

cpu_usage()
{
	echo "cpu $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '
	{if (int(100 - $1) >= 10)
		print int(100 - $1)"%"
	else
		print "0"int(100-$1)"%"}'), "
}

ram_usage()
{
	echo "ram $(free | grep Mem | awk '{printf int($3/$2 * 100.0)"%"}'), "
}

lan_wired()
{
	ip="$(ip -4 -o addr show dev eno1 | awk '{split($4,a,"/");print a[1]}')"
	if [ -z "$ip" ]
	then
		echo ""
	else
		echo "lan $ip, "
	fi
}

lan_wireless()
{
	ip="$(ip -4 -o addr show dev wlo1 | awk '{split($4,a,"/");print a[1]}')"
	if [ -z "$ip" ]
	then
		echo ""
	else
		echo "wlan $ip, "
	fi
}

vol_level()
{
	echo "vol $(amixer get Master | tail -n1 | grep -Po "\\[\\K[^%]*" | head -n1)%, "
}

format_date()
{
	date +"%D %T"
}

#
# Marquee text plex information, print out system information
#
marquee_left()
{
	get_plex_info
	string="$plex_output"
	(( eidx=${#string}+1 ))

	for i in $(seq 1 $eidx)
	do
		get_plex_info
		if [[ "$plex_output" == "$string" ]]; then
		{
			((j=i+1 ))
			strout="$(echo "$string" | cut -b "$i"-)"
			(( --j ))
			[ $j -ne 0 ] && strout="$strout$(echo "$string" | cut -b -$j)"
			if [ -z "$strout" ]
			then
			      begin=""
			else
			      begin="$strout | "
			fi
			$PRINT "$begin$(whoami): $(cpu_usage)$(ram_usage)$(current_bat)$(lan_wired)$(lan_wireless)$(vol_level)$(format_date)"
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
		marquee_left
	done
}

main
