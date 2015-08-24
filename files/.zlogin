# path setup
PATH_RBENV="$HOME/.rbenv/bin"
PATH_HEROKU="/usr/local/heroku/bin"
PATH_NPM="$HOME/.lib/npm/bin"
PATH_RVM="$HOME/.rvm/bin"

export PATH="$HOME/bin:$PATH_RBENV:$PATH_RVM:$GOPATH/bin:$PATH_NPM:$PATH:$PATH_HEROKU"

#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
which rbenv > /dev/null && eval "$(rbenv init -)"


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
