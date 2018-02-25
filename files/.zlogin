#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
which rbenv > /dev/null && eval "$(rbenv init -)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"

# temporarily here instead of zshrc, still not great
autoload -Uz compinit && compinit

which systemctl >&- && systemctl 2>&- --user import-environment PATH
