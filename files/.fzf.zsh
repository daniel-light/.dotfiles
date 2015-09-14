# Setup fzf
# ---------
if [[ ! "$PATH" =~ "$HOME/.dotfiles/build/fzf/bin" ]]; then
  export PATH="$PATH:$HOME/.dotfiles/build/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" =~ "$HOME/.dotfiles/build/fzf/man" && -d "$HOME/.dotfiles/build/fzf/man" ]]; then
  export MANPATH="$MANPATH:$HOME/.dotfiles/build/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- =~ i ]] && source "$HOME/.dotfiles/build/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.dotfiles/build/fzf/shell/key-bindings.zsh"

