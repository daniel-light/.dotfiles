#!/bin/bash
set -u #-o nounset
set -e #-o errexit


dir="$HOME/.dotfiles"
contentdir='files'
olddir='old'

mkdir -p $dir/$contentdir $dir/$olddir && echo 'Creating directory structure'

# make symlinks for dotfiles, saving existing files
cd $dir/$contentdir
for file in $(ls -A); do
	if [ "$(readlink $HOME/$file)" != "$dir/$contentdir/$file" ]; then
		mv ~/$file $dir/$olddir && echo "Backing up ~/$file to $dir/$olddir/$file"
		ln -s $dir/$contentdir/$file ~/$file && echo "Link ~/$file to $dir/$contentdir/$file"
	fi
done

# fetch all of the expected submodules
cd $dir
git submodule init
git submodule update
