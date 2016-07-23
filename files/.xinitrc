udiskie &
[[ -f ~/bin/notifyd-wrapper ]] && notifyd-wrapper &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec i3
