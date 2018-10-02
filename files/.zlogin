#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

# TODO figure out if this was actually costing us milliseconds
if which rbenv > /dev/null; then
	function rbenv {
		unset -f rbenv
		eval "$(rbenv init -)"
		rbenv $*
	}
fi

if which pyenv > /dev/null; then
	function pyenv {
		unset -f pyenv
		eval "$(pyenv init -)"
		pyenv $*
	}
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# [[ -s "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"

# temporarily here instead of zshrc, still not great
# what does -C do? I think it doesn't check the dump, which means this shit will get stale
# TODO task to automatically refresh that shit or something?
autoload -Uz compinit && compinit -C

which systemctl >&- && systemctl 2>&- --user import-environment PATH
