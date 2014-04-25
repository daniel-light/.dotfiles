#!/bin/sh
set -x #-o xtrace
set -u #-o nounset
set -e #-o errexit


dir="$HOME/.dotfiles"
subdirdot='dot'
subdirnot='not'
olddir='old'

mkdir -p $dir/$subdirdot $dir/$subdirnot $dir/$olddir && echo 'Creating directory structure'

cd $dir
cd $subdirdot
for file in $(ls); do
  if [ $(readlink $HOME/.$file) != $dir/$subdirdot/$file ]; then
    mv ~/.$file $dir/$olddir && echo "Backing up ~/.$file to $dir/$olddir/.$file"
    ln -s $dir/$subdirdot/$file ~/.$file && echo "Link ~/.$file to $dir/$subdirdot/$file"
  fi
done

cd $dir
cd $subdirnot
for file in $(ls); do
  if [ $(readlink $HOME/$file) != $dir/$subdirnot/$file ]; then
    mv ~/$file $dir/$olddir && echo "Backing up ~/$file to $dir/$olddir/$file"
    ln -s $dir/$subdirnot/$file ~/$file && echo "Link ~/$file to $dir/$subdirnot/$file"
  fi
done
