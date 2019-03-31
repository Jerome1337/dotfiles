#!/bin/sh

export PATH="${HOME}/bin:${PATH}"

export EDITOR="vim"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 > /dev/null && exec startx
