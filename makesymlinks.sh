#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles				# dotfiles directory
olddir=~/dotfiles_old			# old dotfiles backup directory
files="bash_aliases bashrc vimrc"	# list of files/folders to symlink in homedir
#bashrc_link_created="false"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p "$olddir"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
	# only mv the file if it exists and is not a symlink
	if [ -f ~/."$file" ] && [ ! -L ~/."$file" ]; then
		mv -n ~/."$file" "$olddir"	#-n option means don't overwrite existing files in dotfiles_old
	fi

	#if e.g. ~/.vimrc exists after mv command, then this script must've been run before w/ .vimrc included
	if [ -f ~/."$file" ]; then
		echo "Symlink to $dir/$file already exists"
	else
		echo "Creating symlink to $dir/$file in ~"
		ln -s "$dir"/"$file" ~/."$file"

#		if [ "$file" = "bashrc" ]; then
#			bashrc_link_created="true"
#		fi
	fi
done

# source .bashrc
#echo "Sourcing .bashrc to guarantee any potential changes take effect immediately"
#source ~/.bashrc	#I forgot once again that shell scripts will ignore this
#if [ "$bashrc_link_created" = "true" ]; then	#commented out since I realized updates to .bashrc need sourcing too
printf "\nTo complete the setup, please run the following command:\n\n"
printf "\tsource ~/.bashrc\n\n"
#fi
