which ~/bin/notifyd-wrapper && notifyd-wrapper &
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
which autocutsel && autocutsel -fork &
which autocutsel && autocutsel -selection PRIMARY -fork &
[ -f ~/bin/fuk-capslok ] && ~/bin/fuk-capslok
which syndaemon && syndaemon -i 0.3 -K -d # disable laptop touchpad on keypress, I think
which systemctl && systemctl --user import-environment XAUTHORITY DISPLAY # why did I add this

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
which fcitx && fcitx

exec i3
