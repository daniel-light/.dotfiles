#!/bin/bash
# TODO don't require bash?

# TODO install .pip packages, maybe hook something like this up for gems?

# this script aspires to be an automagic installer, but in reality it's more of
# a guide to answer "how the fuck did I do this last time"

set -o nounset
set -o errexit

# TODO core is apparently not a default target?
selected_targets=("core $@")

source files/.shell-functions.sh

function is_target {
	for target in $selected_targets; do
		if [ $1 == $target -o $1 == "full" ]; then
			return 0
		fi
	done

	return 1
}

function is_arch {
	has_cmd pacman
}

function is_ubuntu {
	has_cmd apt-get
}

DOT_DIR="$HOME/.dotfiles"
BUILD_DIR="$DOT_DIR/build"
STRAPS_DIR="$DOT_DIR/straps"

cd $DOT_DIR
sh install.sh
git submodule init
git submodule update

if is_ubuntu; then
	echo Distro is ubuntu

	# "${VAR-}" checks for unset in bash?
	if [ ! -n "${LANG-}" ] || [ ! $LANG == en_US.UTF-8 ]; then
		sudo locale-gen en_US.UTF-8
		sudo update-locale LANG=en_US.UTF-8
	fi

	#echo Installing apt-add-repository
	sudo apt-get install -y software-properties-common > /dev/null # required for add-apt-repository
	echo apt-add-repository installed

	for target in $selected_targets; do
		selected_pkgs=""

		# add any necessary ppas, but skip ones we detect because it takes
		# a long time
		for ppa in $(ls "$STRAPS_DIR/$target/" | grep -F '.ppa'); do
			ppa="$STRAPS_DIR/$target/$ppa"

			if grep --quiet -F "$(cat $ppa | sed 's/ppa://')" /etc/apt/sources.list.d/*; then
				echo $ppa exists, skipping...
			else
				sudo apt-add-repository -y $(cat "$ppa")
			fi
		done

		# build a package list
		for pkg in $(ls "$STRAPS_DIR/$target/" | grep -F '.apt-get' | sed 's/.apt-get//'); do
			selected_pkgs="${selected_pkgs} $pkg"
		done

	done

	sudo apt-get update
	sudo apt-get install -y $selected_pkgs

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

	sudo systemctl enable ntpd.service
fi

# build some files and shit

"$BUILD_DIR/fzf/install" --bin # --bin so that it doesn't prompt or fuck with our config

# this will action put it in bin/share/whatever, which isn't actually what we want # don't know what this comment is about anymore, maybe the output of fzf install?

function link_env_plugin {
	target_path="${HOME}/.${2-rbenv}/plugins/${1}"
	if [ ! -e "${target_path}"]; then
		ln -s "${DOT_DIR}/build/${1}" "${target_path}"
	fi
}

mkdir -p "$HOME/.rbenv/cache" # if cache exists, then rbenv will cache downloads there by default

if [ -d "$HOME/.rbenv" ]; then
	mkdir -p "$HOME/.rbenv/plugins"

	for plugin in ruby-build rbenv-communal-gems; do
		link_env_plugin "$plugin";
	done
fi

rbenv communize --all

if [ -d "$HOME/.nodenv" ]; then
	mkdir -p "$HOME/.nodenv/plugins"

	link_env_plugin node-build nodenv
fi

if is_target ruby; then
	upgrade-ruby-version
fi

if is_target pyenv; then
	mkdir -p "$HOME/.pyenv/plugins" # TODO see if the cache thing also works for pyenv
	mkdir -p "$HOME/.pyenv/cache" # TODO see if the cache thing also works for pyenv
	upgrade-python-version
fi

if is_target lastpass-cli; then
	if [ $(which pacman) ]; then
		aurget -S --noedit --noconfirm --needed lastpass-cli

	elif [ $(which apt-get) ]; then
		cd "$BUILD_DIR/lastpass-cli"
		make
		sudo make install
		# sudo apt-get install asciidoc # this will annihilate your disk space
		# sudo make install-doc
	fi
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
	elif is_ubuntu; then
		# TODO we should detect if the system is 32 or 64 bit
		cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
		curl https://www.dropbox.com/download?dl=packages/dropbox.py > "$DOT_DIR/files/bin/dropbox-cli"
		chmod +x "$DOT_DIR/files/bin/dropbox-cli"
		~/.dropbox-dist/dropboxd # this requires user intervention TODO ?
	fi

	# ln -s "$HOME/Dropbox/extradots/.hosts" "$HOME/.hosts"
fi

# add-apt-repository ppa:avsm/ppa
# apt update
# apt install opam
