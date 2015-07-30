#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


HOSTNAME=$(hostname)
case $HOSTNAME in
    rosetta)
        urxvtd -q -f -o &

        exec i3
        ;;
    march_pro)
        dropbox &
        pulseaudio --start &
        volumeicon &
        urxvtd -q -f -o &

        # for uim
        export GTK_IM_MODULE=uim
        export QT_IM_MODULE=uim
        export XMODIFIERS=@im=uim
        export XIM_PROGRAM=uim-xim
        uim-xim --async &
        uim-toolbar-gtk3-systray &

        xinput --set-prop     'Logitech M315/M235' 'Device Accel Constant Deceleration' 1.0
        xinput set-button-map 'Logitech M315/M235' 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
        xinput --set-prop 'Genius 2.4G Wireless Mouse' 'Device Accel Constant Deceleration' 2.5
        xinput set-button-map 'Genius 2.4G Wireless Mouse' 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
        xinput set-button-map 'Microsoft Microsoft Wheel Mouse Optical®' 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24

        if xrandr | grep -q 'HDMI1 connected'; then
            xrandr --output eDP1 --auto --primary --output eDP1 --auto --below HDMI1
        fi

        exec i3
        ;;
esac
