#!/bin/sh
set -x #-o xtrace
set -u #-o nounset


dir="$HOME/.dot-files"
subdirdot='dot'
subdirnot='not'
olddir='old'
dotfiles='vimrc zshrc zlogin gemrc'
notfiles=''

#mkdir -p $olddir && echo "Creating $olddir"
mkdir -p ~/.dot-files/{$olddir,$subdirdot,$subdirnot}

cd $dir
cd $subdirdot
for file in $dotfiles; do
  mv ~/.$file $dir/$olddir && echo "Backing up ~/.$file to $dir/$olddir/.$file"
  ln -s $dir/$file ~/.$file && echo "Link ~/.$file to $dir/$file"
done

cd $dir
cd $subdirnot
for file in $notfiles; do
  mv ~/$file $dir/$olddir && echo "Backing up ~/$file to $dir/$olddir/$file"
  ln -s $dir/$file ~/$file && echo "Link ~/$file to $dir/$file"
done
