udiskie &
[ $(which ~/bin/notifyd-wrapper) ] && notifyd-wrapper &
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
exec i3
