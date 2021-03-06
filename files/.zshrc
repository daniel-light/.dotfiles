[ $ZINSTRUMENT ] && . "$HOME/.zinstrumentation"

which most 2>&1 > /dev/null && export PAGER="most"

export DIFFPROG="nvim -d"
export EDITOR="nvim"
export VISUAL="nvim"
set -o emacs # zsh will see $EDITOR think we want vi line editing mode - we don't

## aliases ##

# do this because gnu ls and bsd ls take different options for colorization
ls '--color=auto' > /dev/null 2>&1 && alias -r ls='ls -h --color=auto' || alias -r ls="ls -G"

# having a space at the end of an alias enables expansion inside of the alias
alias -r \
         b='bert' \
         be='bundle exec' \
         bee='beemind' \
         c='pushd' \
         cdc='cd "$(pwd)"' \
         drox='dropbox-cli' \
         e='echo ' \
         g='git' \
         gtypist='gtypist --personal-best --word-processor' \
         n='nvim' \
         noe='nodenv ' \
         p='popd' \
         pye='pyenv ' \
         rbe='rbenv ' \
         remount='s mount $(df --output=target ~/thumb | tail -1) -o remount,exec ' \
         s='sudo ' \
         sdctl='systemctl' \
         sudo='sudo ' \
         t='tmux' \
         timestamp='date "+%Y-%m-%d-%T"' \
         usdctl='systemctl --user'

fpath=(
         "$DOT_DIR/src/zsh-completions"
         "$HOME/.config/zsh/zsh-completions/src"
         # /usr/local/share/zsh-completions # for homebrew
         "$DOT_DIR/build/ytcc/completions/zsh"
         $fpath
)
source "$HOME/.rbenv/completions/rbenv.zsh"
source "$PYENV_ROOT/completions/pyenv.zsh"
source "$HOME/.nodenv/completions/nodenv.zsh"
autoload -Uz compinit && compinit

# perl stuff
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

#options
#PUSHD_MINUS
# don't treat aliases as separate commands for completion purposes
setopt NO_COMPLETE_ALIASES

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# history settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100
SAVEHIST=100

if [ $ZINSTRUMENT ]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi
PROMPT='[%* %m %c] '
[ $ZINSTRUMENT ] && zprof
