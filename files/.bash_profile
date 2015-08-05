bind "set completion-ignore-case on"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedababagacad

PS1="\t:\u:\W$ "

alias be="bundle exec"
alias bm="BUNDLE_GEMFILE=.MyGemfile bundle"
alias bme="BUNDLE_GEMFILE=.MyGemfile bundle exec"
alias g="git"

if [ -f ~/.git-completion.bash ]; then
	  . ~/.git-completion.bash
fi

[ -f ~/.alias-completion.sh ] && . ~/.alias-completion.sh

export CC=gcc

launchctl setenv PATH /opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
# MacPorts Installer addition on 2014-08-11_at_11:57:20: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/bin:$PATH"
