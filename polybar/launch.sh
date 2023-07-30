#!/bin/sh
#
server='prometheus'

name=$(hostname)
# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
#polybar main 2>&1 | tee -a /tmp/polybar.log & disown

## Wait until the processes have been shut down

while pgrep -x polybar >/dev/null; do sleep 1; done

screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)
echo $screens

if [[ $name == $server ]]; then
    for m in $screens; do
        if [[ 'DP-0' == $m ]]; then
            MONITOR=$m TRAY_POS=right polybar main &
        elif [[ 'HDMI-0' == $m ]]; then
            MONITOR=$m TRAY_POS=none polybar secondary &
        fi
    done
    fi
fi



echo "Polybar launched..."
