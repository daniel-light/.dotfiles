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
                jq

fi

# this doesn't work right now
if [ $(which brew) ]; then

	# some notes for self
	# "--HEAD neovim"
	# "avrdude --with-usb"

	brew tap neovim/neovim
fi
