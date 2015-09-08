bind "set completion-ignore-case on"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedababagacad

PS1="\t:\u:\W$ "

alias be="bundle exec"
alias g="git"
alias vim="/usr/bin/vim"

if [ -f ~/.git-completion.bash ]; then
	  . ~/.git-completion.bash
fi

[ -f ~/.alias-completion.sh ] && . ~/.alias-completion.sh

export CC=gcc

launchctl setenv PATH /opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

PATH_MACPORTS="/opt/local/bin:/opt/local/sbin"
PATH_RBENV="$HOME/.rbenv/bin"
PATH_HEROKU="/usr/local/heroku/bin"
PATH_NPM="$HOME/.lib/npm/bin"
PATH_RVM="$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="$HOME/bin:$PATH_RBENV:$PATH_RVM:$PATH_NPM:$PATH_MACPORTS:$PATH:$PATH_HEROKU"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
which rbenv > /dev/null && eval "$(rbenv init -)"
