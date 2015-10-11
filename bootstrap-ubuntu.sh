#!/bin/sh
set -e
set -n

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install -y neovim \ # ppa:neovim-ppa
						git \ # ppa:git-core
						oracle-java8-installer \ # ppa:webupd8team
						newsbeuter \ # random userland
						postgresql libpq-dev
						avrdude gcc-avr avr-libc emacs jq # for atreus firmware
