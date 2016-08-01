#!/bin/bash
# TODO don't require bash?

# this script aspires to be an automagic installer, but in reality it's more of
# a guide to answer "how the fuck did I do this last time"

set -e

selected_targets=("$@")

function is_target {
	for target in $selected_targets; do
		if [ $1 == $target -o $1 == "full" ]; then
			return 0
		fi
	done

	return 1
}

function is_arch {
	which pacman 2>&1 > /dev/null
}

function is_ubuntu {
	which apt-get 2>&1 > /dev/null
}

DOT_DIR="$HOME/.dotfiles"
BUILD_DIR="$DOT_DIR/build"
STRAPS_DIR="$DOT_DIR/straps"

cd $DOT_DIR
git submodule init
git submodule update

if is_ubuntu; then
	echo Distro is ubuntu

	#echo Installing apt-add-repository
	sudo apt-get install -y software-properties-common > /dev/null # required for add-apt-repository
	echo apt-add-repository installed

	target=core
	for ppa in $(ls "$STRAPS_DIR/$target/" | grep -F '.ppa' ); do
		ppa="$STRAPS_DIR/$target/$ppa"

		if grep --quiet -F "$(cat $ppa | sed 's/ppa://')" /etc/apt/sources.list.d/*; then
			echo $ppa exists, skipping...
		else
			sudo apt-add-repository -y $(cat "$ppa")
		fi
	done

	sudo apt-get update

	# just install a minimal set of useful packages in the bootstrap for now
	cat straps/pkgs.apt-get.core | xargs sudo apt-get install -y

	if [ "$1" == "full" ]; then
		cat straps/pkgs.apt-get.cli | xargs sudo apt-get install -y
		cat straps/pkgs.apt-get.x11 | xargs sudo apt-get install -y
		cat straps/pkgs.apt-get.extra | xargs sudo apt-get install -y
	fi

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

if [ $(which pacman) ]; then
	# you should check .pacnew files after bootstrapping
	
	# we need multilib for steam, to enable:
	# go to /etc/pacman.conf and uncomment the two lines for multilib NOT multilib-testing
	# we also need to add the steam lib repo

	# it would be good to set up netctl automatically as well

	selected_pkgs=$(ls "$DOT_DIR/straps/arch/core")

	for target in $selected_targets; do
		if [ -d "$DOT_DIR/straps/arch/$target" ]; then
			selected_pkgs="${selected_pkgs} $(ls $DOT_DIR/straps/arch/$target)"
		fi
	done

	if is_target full; then
		cd "$DOT_DIR/straps/arch"
		for target in $(ls); do
			selected_pkgs="${selected_pkgs} $(ls $DOT_DIR/straps/arch/$target)"
		done
	fi

	sudo pacman -Syu --noconfirm --needed $selected_pkgs

	cd "$BUILD_DIR/aurget"
	yes | makepkg -sri --needed
fi

# build some files and shit

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
	cat straps/gems | xargs gem install
fi

if is_target lastpass-cli; then
	if [ $(which pacman) ]; then
		aurget -S --noedit --noconfirm --needed lastpass-cli

	elif [ $(which apt-get) ]; then # we're going to get this from the AUR on arch
		cd "$BUILD_DIR/lastpass-cli"
		make
		sudo make install
		# sudo apt-get install asciidoc # this will annihilate your disk space
		# sudo make install-doc
	fi
fi

if is_target rust; then
	curl https://sh.rustup.rs -sSf | sh -- --default-toolchain stable
fi

if is_target node; then
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

	# load the nvm function, since we usually only do this for interactives
	export NVM_DIR="/home/daniel/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

	# node is an alias for the latest version of node
	nvm install node  --reinstall-packages-from=node # the switch will preserve packages from the previous tip
	nvm use node
	cat "$DOT_DIR/straps/npms" | xargs npm install -g
fi

if is_target steam; then
	sudo usermod -a -G input $(whoami)

	#if is_arch; then
		#aurget -S steam-libs xboxdrv
		#sudo systemctl enable xboxdrv.service
		#sudo systemctl start xboxdrv.service
	#fi
fi

if is_target dropbox; then
	if is_arch; then
		aurget -S dropbox dropbox-cli thunar-dropbox
		sudo systemctl enable dropbox@$(whoami)
	fi
fi
