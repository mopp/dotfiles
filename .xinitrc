#!/usr/bin/env sh
HOSTNAME=$(hostname)

SYSTEM_RESOURCES=/etc/X11/xinit/.Xresources
if [ -f $SYSTEM_RESOURCES ]; then
    xrdb -merge $SYSTEM_RESOURCES
fi

SYSTEM_MODMAP=/etc/X11/xinit/.Xmodmap
if [ -f $SYSTEM_MODMAP ]; then
    xmodmap $SYSTEM_MODMAP
fi

USER_RESOURCES=$HOME/.Xresources
if [ -f "$USER_RESOURCES" ]; then
    xrdb -merge "$USER_RESOURCES"
fi

ENV_RESOURCES=$HOME/.Xresources.$HOSTNAME
if [ -f "$ENV_RESOURCES" ]; then
    xrdb -merge "$ENV_RESOURCES"
fi

USER_MODMAP=$HOME/.Xmodmap
if [ -f "$USER_MODMAP" ]; then
    xmodmap "$USER_MODMAP"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


function is_existed() {
    [ -x "$(command -v $1)" ]
}

is_existed dropbox && dropbox &
is_existed urxvtd && urxvtd -q -f -o &

# For uim.
export GTK_IM_MODULE="uim"
export QT_IM_MODULE="uim"
export XMODIFIERS="@im=uim"
export XIM_PROGRAM="uim-xim"
uim-xim --async &
uim-toolbar-gtk3-systray &

# Environment specific settings.
case $HOSTNAME in
    flan)
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
        ;;
    *)
        ;;
esac

exec i3
