#!/bin/sh
# This is read by xinit and startx.

export LANG=ja_JP.UTF-8

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d/*; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi


# default
session=${1:-i3}

case $session in
    cinnamon-session)
        exec cinnamon-session;;
    i3)
        exec i3;;
    *)
        # No known session, try to run it as command
        exec $1;;
esac


# ibus-daemon -drx --xim --replace &
# start-pulseaudio-x11 #&
# dropboxd #&
