#!/bin/sh

sudo apt-get install -y git
git clone git@gitlab.com:daniel-light/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
./bootstrap.sh
chsh -s /bin/zsh
zsh --login
./bootstrap.sh ruby # TARGETS
