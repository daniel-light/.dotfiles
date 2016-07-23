PROMPT='[%* %m %c] '

# zsh will think we want vi line editing mode - we don't
export EDITOR="nvim"
set -o emacs

## aliases ##

# do this because gnu ls and bsd ls take different options for colorization
ls '--color=auto' > /dev/null 2>&1 && alias -r ls='ls --color=auto' || alias -r ls="ls -G"
alias -r bx='bundle exec' be='bundle exec' \
         g='git' \
         gtypist='gtypist -b' \
         nv='nvim' \
         n='nvim' \
         drox='dropbox-cli'

fpath=(
         "$HOME/.config/zsh/zsh-completions/src"
         "$HOME/.config/zsh/more-completions"
         # /usr/local/share/zsh-completions # for homebrew
         $fpath
)

# perl stuff
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# this is slow, need a better place for it
autoload -Uz compinit && compinit

#options
#PUSHD_MINUS
# don't treat aliases as separate commands for completion purposes
setopt NO_COMPLETE_ALIASES

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# history settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100
SAVEHIST=100

# fix this later
PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;

export NVM_DIR="/home/daniel/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
