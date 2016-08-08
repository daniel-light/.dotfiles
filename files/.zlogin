#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
which rbenv > /dev/null && eval "$(rbenv init -)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
