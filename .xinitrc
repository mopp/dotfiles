#!/bin/sh
# This is read by xinit and startx.

export LANG=ja_JP.UTF-8

if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d/*; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi


if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

volumeicon &
dropboxd &

# export GTK_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus
# export QT_IM_MODULE=ibus
# ibus-daemon -drx --xim --replace &

export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
export XMODIFIERS=@im=uim
export XIM_PROGRAM=uim-xim
uim-xim --async &
uim-toolbar-gtk3-systray &
urxvtd -q -f -o &

# default
session=${1:-i3}

case $session in
    cinnamon-session)
        exec cinnamon-session;;
    i3)
        exec i3 ;;
    *)
        # No known session, try to run it as command
        exec $1;;
esac

# sh ~/.fehbg &
# exec --no-startup-id urxvt
