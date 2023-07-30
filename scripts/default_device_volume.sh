#!/bin/sh
##########
## This script was made for my needs and to render it in polybar
##
## If someone wants to use it, you're free to modify it as you need
##########


function get_help() 
{
	echo 'Arguments:'
	echo '  $1: device [input|output]'
	echo '  $2: mode [g|s|m]'
	echo '        s: set volume'
	echo '        g:  get volume'
	echo '        m: toggles mute'
	echo '  $3: level  or output format'
	echo '        - `s` mode:'
	echo '                +5: increases volume by 5%'
	echo '                -5: decreases level by 5%'
	echo '                80: sets level to 80%'
	echo '        - `g` mode '
	echo '                numbers:  77%'
	echo '                dotted:  '
	echo 'Examples:'
	echo 'default_device_volume.sh g '
	echo 'default_device_volume.sh s +5'
	echo 'default_device_volume.sh s -5'
	echo 'default_device_volume.sh s 80'
	echo 'default_device_volume.sh m'
}


if [ "$#" -ge 1 ]; then

	case $1 in 
		'input')
			device=$(pactl info | grep 'Default Source' | cut -d ':' -f 2 | xargs)
			type='source'
			;;
		'output')
			device=$(pactl info | grep 'Default Sink' | cut -d ':' -f 2 | xargs)
			type='sink'
			;;
		*)
			get_help
			exit
			;;
		esac

	current_volume=$(pactl get-$type-volume $device | cut -d '/' -f 2 | head -n 1 | cut -d '%' -f 1 | xargs)

    case $2 in 
        'm')
            pactl set-$type-mute $device toggle
            ;;
        's')
			if [[ $3 =~ ^\+ ]]; then
				new_volume=$(expr $current_volume + ${3:1})
			elif [[ $3 =~ ^\- ]]; then
				new_volume=$(expr $current_volume - ${3:1})
			else
				new_volume=$3
			fi

            if [[ ($new_volume -ge 0) && ($new_volume -le 100) ]]; then
                pactl set-$type-volume $device $new_volume%
            elif [ $new_volume -lt 0 ]; then
                pactl set-$type-volume $device 0%
            else
                pactl set-$type-volume $device 100%
            fi
            ;;
        'g')
            if [[ $1 = 'input' ]]; then
                icon=''
            else
                icon='󰓃'
            fi

            is_muted=$(pactl get-$type-mute $device | cut -d ':' -f 2 | xargs)
            start_muted_color='%{F#FD9F9F}'
            end_muted_color='%{F-}'

            case $3 in 
                'numbers')
                    if [ 'yes' = $is_muted ]; then
                        echo $start_muted_color$icon$current_volume'%'$end_muted_color
                    else
                        echo $icon$current_volume%
                    fi
                    ;;
                'dotted')
                    dot_full=''
                    dot_empty=''
                    dotted_icon=''
                    full_dots=$(expr $current_volume / 20)
                    for i in {1..5}
                    do
                        if [ $full_dots -gt 0 ]; then
                            dotted_icon="$dotted_icon$dot_full"
                            full_dots=$(expr $full_dots - 1)
                        else
                            dotted_icon="$dotted_icon$dot_empty"
                        fi
                    done

                    if [ 'yes' = $is_muted ]; then
                        echo $start_muted_color$icon$dotted_icon$end_muted_color
                    else
                        echo $icon$dotted_icon
                    fi
                    ;;
                *)
                    echo 'N/A'
                    ;;
            esac
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
