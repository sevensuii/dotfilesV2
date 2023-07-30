#!/bin/sh
##########
## This script was made for my needs and to render it in polybar
##
## If someone wants to use it, you're free to modify it as you need
##########

function get_help()
{
    echo 'Arguments'
    echo '  $1: vpn client'
    echo '  $2: bar to render'
    echo '  $3: text to show'
    echo 'Examples:'
    echo 'vpn_checker.sh openvpn polybar'
}

if [[ "$#" -ge 1 ]]; then
    
    # isActive=$(ps -aux | grep $1 | wc -l | xargs)
    isActive=$(pgrep $1)
    # echo $isActive
    if [[ $isActive -gt 3 ]]; then
        case $2 in 
            'polybar')
                echo "󰖂 "$3
                # echo "%{F#00FF3C}󰖂 "$1"%{F-}"
                ;;
            *)
                echo $1"=>"$isActive
                ;;
        esac
    else
        echo ''
    fi
else
    get_help
fi
