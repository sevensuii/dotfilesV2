#!/bin/sh
##########
## This script was made for my needs and to render it in polybar
##
## If someone wants to use it, you're free to modify it as you need
##########

function get_help()
{
    echo 'Arguments'
    echo '  $1: manufacturer of the cpu [intel|amd]'
    echo '  $2: format to render [polybar|null]'
    echo '  $3: margin 1, NORMAL if temp is below this number'
    echo '  $4: margin 2, WARNING if temp is abobe $3 and below $4, ALERT if is abobe $4'
    echo 'Examples:'
    echo 'get_cpu_temp.sh intel'
    echo 'get_cpu_temp.sh amd'
    echo 'get_cpu_temp.sh amd polybar'
    echo 'get_cpu_temp.sh amd polybar 43 46'
}

if [[ $# -ge 1 ]]; then
    temp_icon=
    temp_unit='°C'
    case $1 in 
        'intel')
            temp=$(sensors | grep 'Package id 0:' | cut -d '+' -f 2 | cut -d '(' -f 1 | cut -c1-2)
            ;;
        'amd')
            temp=$(sensors | grep Tctl | cut -d '+' -f 2 | cut -c1-2)
            ;;
        *)
            get_help
            exit
            ;;
    esac

    case $2 in 
        'polybar')
            if [[ $temp -le $3 ]]; then
                echo $temp_icon' '$temp$temp_unit
            elif [[ ($temp -gt $3) && ($temp -lt $4) ]]; then
                echo '%{F#FFFF00}'$temp_icon' '$temp$temp_unit'%{F-}'
            elif [[ $temp -ge $4 ]]; then
                echo '%{F#A54242}'$temp_icon' '$temp$temp_unit'%{F-}'
            else
                echo '%{F#A54242}'$temp_icon' N/A%{F-}'
            fi
            ;;
        *)
            echo $temp_icon' '$temp$temp_unit
            ;;
    esac
else
    get_help
    exit
fi