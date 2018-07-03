#!/bin/bash
# This scripts creates symbolic links from ~/dotfiles dir to ~/ as well as backup existing ones.
# This script currently manages: .gitconfig, .profile, .zshrc, and .vimrc files.

dir=~/dotfiles
backup_dir=~/dotfiles_bckup

files=".gitconfig .profile .zshrc .vimrc"


# check for/create backup directory
if [ -d "$backup_dir" ]; then
	echo "Existing backup directory found - will override managed files."
else
	mkdir $backup_dir
fi

# Create/backup managed files
for file in $files;
do
	printf "\n---$file---\n"
	if [ -e "$dir/$file" ]; then
		echo "Backing up to $backup_dir/$file"

		if [ -e "$HOME/$file" ]; then
			mv ~/$file $backup_dir/
		else
			echo "~/$file not found, skipping backup."
		fi

		echo "Creating symlink to ~/$file"
		ln -s $dir/$file ~/$file
		echo "Symlink created."

	else
		echo "FILE NOT FOUND: $dir/$file"
	fi
done
