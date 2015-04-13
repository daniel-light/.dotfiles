# path setup
PATH_RBENV="$HOME/.rbenv/bin"
PATH_HEROKU="/usr/local/heroku/bin"
PATH_NPM="$HOME/.lib/npm/bin"

export PATH="$HOME/bin:$PATH_RBENV:$GOPATH/bin:$PATH_NPM:$PATH:$PATH_HEROKU"

#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
eval "$(rbenv init -)"


#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
