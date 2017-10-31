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
            # In the setting below, it considers
            #   The external monitor size is 1920x1080
            #   The default monitor size is 2560x1440
            # It becomes (1920x1080) * 1.4 = (2688x1512) if scale is 1.4x1.4.
            # Next, its X position begins from 2688 if you would like to put default monitor on the right of the external monitor.
            xrandr --output HDMI1 --primary --scale 1.4x1.4 --panning 2688x1512 --output eDP1 --auto --panning 2560x1440+2688+0 --right-of HDMI1
            # (1920x1080) * 1.3 = (2496x1404)
            # (1920x1080) * 1.2 = (2304x1296)
        fi

        exec i3
        ;;
    rosetta)
        dropbox &
        slack &
        urxvtd -q -f -o &

        # for uim
        export GTK_IM_MODULE="uim"
        export QT_IM_MODULE="uim"
        export XMODIFIERS="@im=uim"
        export XIM_PROGRAM="uim-xim"
        uim-xim --async &
        uim-toolbar-gtk3-systray &

        xinput --set-prop 12 286 0
        xinput --set-prop 12 290 -0.5

        exec i3
        ;;
esac
