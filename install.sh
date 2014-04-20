#!/bin/sh
set -x #-o xtrace
set -u #-o nounset


dir="$HOME/.dotfiles"
subdirdot='dot'
subdirnot='not'
olddir='old'
dotfiles='vimrc zshrc zlogin gemrc'
notfiles=''

#mkdir -p $olddir && echo "Creating $olddir"
mkdir -p $dir/{$olddir,$subdirdot,$subdirnot}

cd $dir
cd $subdirdot
for file in $dotfiles; do
  mv ~/.$file $dir/$olddir && echo "Backing up ~/.$file to $dir/$olddir/.$file"
  ln -s $dir/$subdirdot/$file ~/.$file && echo "Link ~/.$file to $dir/$subdirdot/$file"
done

cd $dir
cd $subdirnot
for file in $notfiles; do
  mv ~/$file $dir/$olddir && echo "Backing up ~/$file to $dir/$olddir/$file"
  ln -s $dir/$subdirnot/$file ~/$file && echo "Link ~/$file to $dir/$subdirnot/$file"
done
