#!/bin/bash
# TODO don't require bash?

if [ $(which apt-get) ]; then

	sudo add-apt-repository -y ppa:neovim-ppa/unstable
	sudo add-apt-repository -y ppa:git-core/ppa
	sudo add-apt-repository -y ppa:webupd8team/java

	sudo apt-get update

	cat straps/pkgs.apt-get | xargs sudo apt-get install -y

# TODO install node / npm
# cat straps/npms | xargs npm install -g

# TODO install ruby
# cat straps/gems | xargs gem install

multirust > /dev/null || \
	curl -sf \
	https://raw.githubusercontent.com/brson/multirust/master/blastoff.sh | sh
multirust update

fi

# this doesn't work right now
# also this package list is not up to date
if [ $(which brew) ]; then

	brew tap homebrew/dupes
	brew install grep --with-default-names

	brew tap neovim/neovim
	brew install --HEAD neovim

	brew install avrdude --with-usb
	brew install node zsh p7zip
fi

# build some files and shit

DOT_DIR="$HOME/.dotfiles"
BUILD_DIR="$DOT_DIR/build"

cd $DOT_DIR
git submodule init
git submodule update
"$BUILD_DIR/fzf/install"
# this will action put it in bin/share/whatever, which isn't actually what we want
# PREFIX="$BIN_DIR" "$BUILD_DIR/ruby-build/install.sh"
mkdir "$HOME/.rbenv/plugins"
ln -s "$DOT_DIR/build/ruby-build" "$HOME/.rbenv/plugins/ruby-build" 
