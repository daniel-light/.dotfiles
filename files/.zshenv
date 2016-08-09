export FZF_DEFAULT_COMMAND='find .'
export GOPATH="$HOME/.lib/go"
export HOSTALIASES="$HOME/.hosts"

# path setup
PATH_RBENV="$HOME/.rbenv/bin"
PATH_HEROKU="/usr/local/heroku/bin"
PATH_RVM="$HOME/.rvm/bin"
PATH_CARGO="$HOME/.cargo/bin"
PATH_PERL="$HOME/perl5/bin"

# http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command
for x in "$HOME/bin" "$PATH_RBENV" "$PATH_RVM" "$PATH_CARGO" "$GOPATH/bin" "$PATH_PERL"; do
  case ":$PATH:" in
    *":$x:"*) :;; # already there
    *) PATH="$x:$PATH";;
  esac
done

# http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command
for x in "$PATH_HEROKU"; do
  case ":$PATH:" in
    *":$x:"*) :;; # already there
    *) PATH="$PATH:$x";;
  esac
done

if [[ -f "$HOME/.secure-env" ]]; then
	source "$HOME/.secure-env"
fi
