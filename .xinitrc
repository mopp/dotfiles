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
    flan)
        dropbox &
        urxvtd -q -f -o &

        # for uim
        export GTK_IM_MODULE="uim"
        export QT_IM_MODULE="uim"
        export XMODIFIERS="@im=uim"
        export XIM_PROGRAM="uim-xim"
        uim-xim --async &
        uim-toolbar-gtk3-systray &

        if xrandr | grep -q 'HDMI1 connected'; then
            xrandr --output eDP1 --auto --primary --output eDP1 --auto --below HDMI1
        fi

        exec i3
        ;;
esac
