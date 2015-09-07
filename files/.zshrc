PROMPT='[%* %m %c] '

# aliases
alias -r ls='ls --color=auto' \
         bx='bundle exec' be='bundle exec' \
         g='git' \
         gtypist='gtypist -b' \
         nv='nvim'

fpath=("$HOME/.config/zsh/zsh-completions/src" $fpath)

#options
#PUSHD_MINUS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
