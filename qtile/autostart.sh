#!/bin/bash

#cd ~/.config/qtile/

## Performance cpu mode
cpupower-gui -b

## (tmp) Set screen layout
~/screens.sh

## Start notification daemon
/usr/bin/dunst &

## Start compositor
picom &

## Restore wallpapers
nitrogen --restore &

## Launch bar
~/.config/polybar/launch.sh &

## Setup keyboard layouts
setxkbmap "us,es" -option -option grp:win_space_toggle
