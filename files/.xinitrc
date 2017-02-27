which ~/bin/notifyd-wrapper && notifyd-wrapper &
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
which autocutsel && autocutsel -fork &
which autocutsel && autocutsel -selection PRIMARY -fork &
[ -f ~/bin/fuk-capslok ] && ~/bin/fuk-capslok
which syndaemon && syndaemon -i 0.3 -K -d
which systemctl && systemctl --user import-environment XAUTHORITY DISPLAY
exec i3
