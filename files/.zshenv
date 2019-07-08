[ $ZINSTRUMENT ] && . "$HOME/.zinstrumentation"

setopt noglobalrcs

export DOT_DIR="$HOME/.dotfiles"
if which fd 2>&1 > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f'
else
  export FZF_DEFAULT_COMMAND='find .'
fi
export GOPATH="$HOME/.lib/go"
export HOSTALIASES="$HOME/.hosts"
export ANDROID_HOME="/opt/android-sdk"
export TERMINAL="st" # nonstandard var that i3-sensible-terminal looks for
export PYENV_ROOT="$HOME/.pyenv"
export RBENV_SHELL="zsh" # manual rbenv setup
export PYENV_SHELL="zsh" # manual pyenv setup

# path setup
PATH_RBENV="$HOME/.rbenv/bin"
PATH_RBENV_SHIMS="$HOME/.rbenv/shims" # manual rbenv setup
PATH_PYENV="$PYENV_ROOT/bin"
PATH_PYENV_SHIMS="$PYENV_ROOT/shims" # manual pyenv setup
PATH_NODENV="$HOME/.nodenv/bin"
PATH_NODENV_SHIMS="$HOME/.nodenv/shims" # manual nodenv setup
PATH_HEROKU="/usr/local/heroku/bin"
PATH_RVM="$HOME/.rvm/bin"
PATH_CARGO="$HOME/.cargo/bin"
PATH_PERL="$HOME/perl5/bin"
PATH_LUAROCKS="$HOME/.luarocks/bin"

# this is in a function so we can call it again in zshrc
# not that we actually do that? idk man
# oh, we do in .zprofile, because apparently arch will fuck it up otherwise
function setup_path {
  # http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command
  for x in "$DOT_DIR/build/IBM_Cloud_CLI" "$PATH_PERL" "$GOPATH/bin" "$PATH_CARGO" "$PATH_RVM" "$PATH_LUAROCKS" "$HOME/.local/bin" "$PATH_PYENV" "$PATH_PYENV_SHIMS" "$PATH_NODENV" "$PATH_NODENV_SHIMS" "$PATH_RBENV" "$PATH_RBENV_SHIMS" "$HOME/bin" ; do
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

export NVM_DIR="$HOME/.nvm"

if [ -d "$HOME/.nvm" ] && ; then
  function nvm () {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" 2> /dev/null # This loads nvm
    nvm use --delete-prefix default --silent
    nvm $*
  }
fi

if [[ -f "$HOME/.env" ]]; then
	source "$HOME/.env"
fi
# is there a principled difference between these two? idk dude
if [[ -f "$HOME/.secure-env" ]]; then
	source "$HOME/.secure-env"
fi

export TRANSMISSION_HOME="$HOME/.config/transmission"
