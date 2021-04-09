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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Notifications
dunst &

# Keyboard Layout
setxkbmap -layout us,el -variant qwerty -option "grp:ctrl_alt_toggle" &

# Wallpaper
feh --bg-scale /home/jim/Downloads/wallpaper1.png &


# Compositor
#xcompmgr -f -F -c &
devilspie -a &
picom --inactive-opacity=0.95 --active-opacity=0.95 -c --config /dev/null -f &

# Lock Screen
xautolock -time 3 -locker slock &

# Status Monitor
/usr/bin/status.sh &

# key repeat time
xset r rate 200 &

twm &
xclock -geometry 50x50-1+1 &
xterm -geometry 80x50+494+51 &
xterm -geometry 80x20+494-0 &
exec dwm
#exec xterm -geometry 80x66+0+0 -name login
