#!/bin/bash
# TODO don't require bash?

# this script aspires to be an automagic installer, but in reality it's more of
# a guide to answer "how the fuck did I do this last time"

selected_targets=("$@")

function is_target {
	for target in $selected_targets; do
		if [ $1 == $target -o $1 == "full" ]; then
			return 0
		fi
	done

	return 1
}

if [ $(which apt-get) ]; then

	sudo apt-get install -y software-properties-common # required for add-apt-repository

	sudo add-apt-repository -y ppa:neovim-ppa/unstable
	sudo add-apt-repository -y ppa:git-core/ppa

	sudo apt-get update

	# just install a minimal set of useful packages in the bootstrap for now
	cat straps/pkgs.apt-get.core | xargs sudo apt-get install -y

	if [ "$1" == "full" ]; then
		cat straps/pkgs.apt-get.cli | xargs sudo apt-get install -y
		cat straps/pkgs.apt-get.x11 | xargs sudo apt-get install -y
		cat straps/pkgs.apt-get.extra | xargs sudo apt-get install -y
	fi

# TODO install node / npm
# cat straps/npms | xargs npm install -g

#	curl https://sh.rustup.rs -sSf | sh

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

DOT_DIR="$HOME/.dotfiles"
BUILD_DIR="$DOT_DIR/build"

if [ $(which pacman) ]; then
	#sudo pacman -Syu
	# you should check .pacnew files after bootstrapping

	selected_pkgs=$(ls "$DOT_DIR/straps/arch/core")

#	for target in "$DOT_DIR/straps/arch"; do
#		if is_target "$target"; then
#			target="$DOT_DIR/straps/arch/$target"
#			selected_pkgs="${selected_pkgs}\n$(ls $target)"
#		fi
#	done

	for target in $selected_targets; do
		if [ -d "$DOT_DIR/straps/arch/$target" ]; then
			selected_pkgs="${selected_pkgs} $(ls $DOT_DIR/straps/arch/$target)"
		fi
	done

	if [ is_target "full" ]; then
		cd "$DOT_DIR/straps/arch"
		for target in $(ls); do
			selected_pkgs="${selected_pkgs} $(ls $DOT_DIR/straps/arch/$target)"
		done
	fi

	sudo pacman -Syu --needed $selected_pkgs
	echo $selected_pkgs
fi

# build some files and shit

cd $DOT_DIR
git submodule init
git submodule update

"$BUILD_DIR/fzf/install" --bin # --bin so that it doesn't prompt or fuck with our config

# this will action put it in bin/share/whatever, which isn't actually what we want # don't know what this comment is about anymore, maybe the output of fzf install?

mkdir -p "$HOME/.rbenv/plugins"
if [ ! -e "$HOME/.rbenv/plugins/ruby-build" ]; then 
	ln -s "$DOT_DIR/build/ruby-build" "$HOME/.rbenv/plugins/ruby-build" 
fi

if is_target ruby; then
	# this is definitely a good way to install ruby
	rbenv install --list | grep '^[[:space:]]*[[:digit:]]' | grep -v '-' | tail -n 1 | xargs rbenv install --keep
	rbenv install --list | grep '^[[:space:]]*[[:digit:]]' | grep -v '-' | tail -n 1 | xargs rbenv global # what shell variables? nonsense
	# cat straps/gems | xargs gem install
fi

if is_target lpass; then
	if [ $(which apt-get) ]; then # we're going to get this from the AUR on arch
		cd "$BUILD_DIR/lastpass-cli"
		make
		sudo make install
		# sudo apt-get install asciidoc # this will annihilate your disk space
		# sudo make install-doc
	fi
fi
