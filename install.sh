#!/bin/sh
set -x #-o xtrace
set -u #-o nounset
set -e #-o errexit


dir="$HOME/.dotfiles"
subdirdot='dot'
subdirnot='not'
olddir='old'

#mkdir -p $olddir && echo "Creating $olddir"
mkdir -p $dir/{$olddir,$subdirdot,$subdirnot}

cd $dir
cd $subdirdot
for file in $(ls); do
  mv ~/.$file $dir/$olddir && echo "Backing up ~/.$file to $dir/$olddir/.$file"
  ln -s $dir/$subdirdot/$file ~/.$file && echo "Link ~/.$file to $dir/$subdirdot/$file"
done

cd $dir
cd $subdirnot
for file in $(ls); do
  mv ~/$file $dir/$olddir && echo "Backing up ~/$file to $dir/$olddir/$file"
  ln -s $dir/$subdirnot/$file ~/$file && echo "Link ~/$file to $dir/$subdirnot/$file"
done
