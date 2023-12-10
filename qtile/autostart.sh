#!/bin/bash

#cd ~/.config/qtile/

## Performance cpu mode
cpupower-gui -p

## (tmp) Set screen layout
~/screens.sh

## Start notification daemon
/usr/bin/dunst &

## Start compositor
picom &

## Restore wallpapers
nitrogen --restore &

## Sets screen timeout to 30 minutes
xset -dpms && xset s 2700

## Launch bar
~/.config/polybar/launch.sh &

## Setup keyboard layouts
setxkbmap "us,es" -option -option grp:win_space_toggle
