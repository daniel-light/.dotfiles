#!/bin/sh
set -e
set -n

# inner arrays are laid out as: ubuntu, 
TARGETS=(
	(neovim)
	(git)
	(oracle-java8-installer)
	(newsbeuter)
	(postgresql)
	(libpq-dev)
	(avrdude)
	(avr-libc)
	(emacs)
	(jq)
)

if [ $(which apt-get) ]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo add-apt-repository ppa:git-core/ppa
	sudo add-apt-repository ppa:webupd8team/java

	sudo apt-get update

	for target in ${TARGETS[@]}; do
		sudo apt-get install -y $target
	done

	# sudo apt-get install -y neovim \ # ppa:neovim-ppa
	# 						git \ # ppa:git-core
	# 						oracle-java8-installer \ # ppa:webupd8team
	# 						newsbeuter \ # random userland
	# 						postgresql libpq-dev \
	# 						avrdude gcc-avr avr-libc emacs jq # for atreus firmware
fi
