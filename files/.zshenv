export GOPATH="$HOME/.lib/go"
export FZF_DEFAULT_COMMAND='find .'

if [[ -f "$HOME/.secure-env" ]]; then
	source "$HOME/.secure-env"
fi
