#!/usr/bin/env bash
set -u #-o nounset
set -e #-o errexit

DOT_DIR="$HOME/.dotfiles"
OLD_DIR="$DOT_DIR/old"
PUBLIC_DIR="$DOT_DIR/files"
PRIVATE_DIR="$HOME/Dropbox/extradots"

cd $HOME # just in case?

# $OLD_DIR has no tracked files, and as such isn't guaranteed to exist
mkdir -p "$OLD_DIR" && echo 'Creating directory structure'

# make symlinks for dotfiles, saving existing files
for files_dir in "$PUBLIC_DIR" "$PRIVATE_DIR"; do
	for basename in $(ls -A "$files_dir"); do
		full_path="$files_dir/$basename"
		if [ "$(readlink $HOME/$basename)" != "$full_path" ]; then

			# onlly back up if the file is not a symlink
			if [ -L "$HOME/$basename" ]; then
				rm "$HOME/$basename"
			elif [ -e "$HOME/$basename" ]; then
				echo Backing up $basename
				mv "$HOME/$basename" "$OLD_DIR"
			fi

			echo Linking $basename to $files_dir
			ln -s "$full_path" "$HOME/$basename"

		# else
			# echo Skipping $basename
		fi
	done
done
