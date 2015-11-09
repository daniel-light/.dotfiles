#!/bin/bash
# TODO don't require bash?

if [ $(which apt-get) ]; then

	sudo add-apt-repository -y ppa:neovim-ppa/unstable
	sudo add-apt-repository -y ppa:git-core/ppa
	sudo add-apt-repository -y ppa:webupd8team/java

	sudo apt-get update

	sudo apt-get install -y \
                neovim \
                git \
                oracle-java8-installer \
                newsbeuter \
                postgresql \
                libpq-dev \
                avrdude \
                avr-libc \
                emacs \
                jq \
				zsh \
				p7zip

fi

# this doesn't work right now
if [ $(which brew) ]; then

	brew tap homebrew/dupes
	brew install grep --with-default-names

	brew tap neovim/neovim
	brew install --HEAD neovim

	brew install avrdude --with-usb
	brew install node zsh p7zip
fi
