#!/bin/sh

compton &

numlockx &

setxkbmap fr

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec i3
