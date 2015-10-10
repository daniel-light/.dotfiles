#!/bin/sh
set -e
set -n

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install -y neovim git oracle-java8-installer \ # from the ppas
						postgresql libpq-dev
