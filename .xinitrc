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
xinput --set-prop 'Logitech Unifying Device. Wireless PID:4009' 'Device Accel Constant Deceleration' 2.0 
xinput set-button-map 'Logitech Unifying Device. Wireless PID:4009' 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 
xinput set-button-map 'Microsoft Microsoft Wheel Mouse Optical®' 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24

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
