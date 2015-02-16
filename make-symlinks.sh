#!/bin/bash
# make-symlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles

dir=~/dotfilesolddir=~/dotfiles_old
files=".emacs .gitconfig .bash_profile"

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

echo "Changing to the $dir directory"
cd $dir
echo "...done"

for file in $files; do
    echo "Moving existing dotfile $file from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
