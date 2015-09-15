PROMPT='[%* %m %c] '

## aliases ##

# do this because gnu ls and bsd ls take different options for colorization
ls '--color=auto' > /dev/null 2>&1 && alias -r ls='ls --color=auto' || alias -r ls="ls -G"
alias -r bx='bundle exec' be='bundle exec' \
         g='git' \
         gtypist='gtypist -b' \
         nv='nvim'

fpath=("$HOME/.config/zsh/zsh-completions/src" $fpath)

#options
#PUSHD_MINUS
# don't treat aliases as separate commands for completion purposes
setopt NO_COMPLETE_ALIASES

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
