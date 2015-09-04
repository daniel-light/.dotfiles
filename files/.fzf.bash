# Setup fzf
# ---------
if [[ ! "$PATH" =~ "/Users/daniellight/.dotfiles/build/fzf/bin" ]]; then
  export PATH="$PATH:/Users/daniellight/.dotfiles/build/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" =~ "/Users/daniellight/.dotfiles/build/fzf/man" && -d "/Users/daniellight/.dotfiles/build/fzf/man" ]]; then
  export MANPATH="$MANPATH:/Users/daniellight/.dotfiles/build/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- =~ i ]] && source "/Users/daniellight/.dotfiles/build/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/daniellight/.dotfiles/build/fzf/shell/key-bindings.bash"

