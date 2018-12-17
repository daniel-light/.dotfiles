[ $ZINSTRUMENT ] && . "$HOME/.zinstrumentation"

#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# [[ -s "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"

# TODO really it would be better to watch the gems dir or something
(rbenv rehash &) &> /dev/null # manual rbenv setup
(pyenv rehash &) &> /dev/null # manual pyenv setup

which systemctl >&- && systemctl 2>&- --user import-environment PATH
