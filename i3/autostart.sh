#!/bin/bash

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
HOST=$(cat "$PWD/../host")

## Set startup volume
amixer -q -D pulse set Master 20% unmute &
#pactl set-sink-volume 1 -- '20%' &

## Set LCD brightness
if [ "$HOST" != "home" ] ; then
  xbacklight -set 50 &
fi

## Install dispwin profile for the Eizo monitor @ home
if [ "$HOST" == "home" ] ; then
  dispwin -v -d1 -c -I ~/.local/share/dispcalGUI/storage/FS2333\ 2014-12-22\ D6500\ 2.2\ F-S\ 3xCurve+MTX/FS2333\ 2014-12-22\ D6500\ 2.2\ F-S\ 3xCurve+MTX.icc
fi

## Set gb as keyboard layout
setxkbmap gb

## Activate CAPS LOCK as compose key
xmodmap ~/.Xmodmap &

## Notification daemon
dunst &

## Setup montiors for work
if [ "$HOST" == "home" ] ; then
  xrandr --output HDMI-0 --auto --primary
  xrandr --output DVI-1 --auto --right-of HDMI-0
elif [ "$HOST" == "work" ] ; then
  xrandr --output eDP1 --auto
  xrandr --output HDMI2 --auto --left-of eDP1 --primary
fi

## Always activate num-lock.
if hash numlockx 2>/dev/null; then
  numlockx on
else
  echo "numlockx is required. Please install it."
fi

## Start dropbox if available
if hash dropbox 2>/dev/null; then
  dropbox start &
else
  echo "Dropbox is not installed."
fi

## Start workrave if available
if hash workrave 2>/dev/null; then
  workrave &
else
  echo "Workrave is not installed."
fi

# add possibility to switch between UK and DE layout (https://faq.i3wm.org/question/4761/keyboard-input-language-pro$
#setxkbmap -model pc105 -layout gb,de -option grp:shifts_toggle
