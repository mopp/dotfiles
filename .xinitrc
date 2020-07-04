#!/usr/bin/env sh
HOSTNAME=$(hostname)

SYSTEM_RESOURCES=/etc/X11/xinit/.Xresources
[ -f $SYSTEM_RESOURCES ] && xrdb -merge $SYSTEM_RESOURCES

USER_RESOURCES=$HOME/.Xresources
[ -f "$USER_RESOURCES" ] && xrdb -merge "$USER_RESOURCES"

ENV_RESOURCES=$HOME/.Xresources.$HOSTNAME
[ -f "$ENV_RESOURCES" ] && xrdb -merge "$ENV_RESOURCES"

SYSTEM_MODMAP=/etc/X11/xinit/.Xmodmap
[ -f "$SYSTEM_MODMAP" ] && xmodmap "$SYSTEM_MODMAP"

USER_MODMAP=$HOME/.Xmodmap
[ -f "$USER_MODMAP" ] && xmodmap "$USER_MODMAP"

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

command -v dropbox && dropbox &

# fcitx.
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export QT5_IM_MODULE=fcitx
export QT_QPA_PLATFORMTHEME=qt5ct
fcitx -rd &

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
