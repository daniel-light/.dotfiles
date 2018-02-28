export DOT_DIR="$HOME/.dotfiles"
export FZF_DEFAULT_COMMAND='find .'
export GOPATH="$HOME/.lib/go"
export HOSTALIASES="$HOME/.hosts"
export ANDROID_HOME="/opt/android-sdk"
export TERMINAL="st" # nonstandard var that i3-sensible-terminal looks for

# path setup
PATH_RBENV="$HOME/.rbenv/bin"
PATH_HEROKU="/usr/local/heroku/bin"
PATH_RVM="$HOME/.rvm/bin"
PATH_CARGO="$HOME/.cargo/bin"
PATH_PERL="$HOME/perl5/bin"
PATH_LUAROCKS="$HOME/.luarocks/bin"

# this is in a function so we can call it again in zshrc
function setup_path {
  # http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command
  for x in "$PATH_PERL" "$GOPATH/bin" "$PATH_CARGO" "$PATH_RVM" "$PATH_LUAROCKS" "$HOME/.local/bin" "$PATH_RBENV" "$HOME/bin" ; do
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
}

setup_path

if [[ -f "$HOME/.secure-env" ]]; then
	source "$HOME/.secure-env"
fi
