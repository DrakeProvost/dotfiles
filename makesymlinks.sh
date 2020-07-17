#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles				# dotfiles directory
olddir=~/dotfiles_old			# old dotfiles backup directory
files="vimrc bash_aliases bashrc"	# list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
	mv -n ~/.$file ~/dotfiles_old/	#-n option means don't overwrite existing files in dotfiles_old

	#if e.g. ~/.vimrc exists after mv command, then this script must've been run before w/ .vimrc included
	if [ -f ~/.$file ]; then
		echo "Symlink to $dir/$file already exists"
	else
		echo "Creating symlink to $dir/$file in ~"
		ln -s $dir/$file ~/.$file
	fi
done

# source .bashrc
echo "Sourcing .bashrc to guarantee any potential changes take effect immediately"
source ~/.bashrc
