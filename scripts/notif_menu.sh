#!/bin/bash
#

function get_help()
{
	echo 'This script is made to use it with dunstctl'
	echo 'Arguments'
	echo '	$1: method to be used [close-all|count|history]'
	
}
if [[ $# -gt 0 ]]; then
	no_notif_icon=''
	notif_icon=''
	notif=$(dunstctl count | grep History | cut -d ':' -f 2 | xargs)

	case $1 in
		'close-all')
			dunstctl close-all
			;;
		'count')
			paused=$(dunstctl is-paused)
			if [[ $paused == 'true' ]]; then
				echo ''
			else
				echo $notif
			fi
			#if [[ $notif -gt 0 ]]; then
			#	echo $notif_icon $notif
			#else
			#	echo $no_notif_icon $notif
			#fi
			;;
		'history')
			notif_to_show=8
			if [[ $notif -lt $notif_to_show ]]; then
				notif_to_show=$notif
				echo $notif_to_show
			fi

			for i in $(seq 1 $notif_to_show); do
				dunstctl history-pop
			done
			;;
		*)
			get_help
			exit
			;;
	esac
else
	get_help
	exit
fi
