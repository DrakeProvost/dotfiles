# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Everything below this point has been added by Drake Provost 
##############################################################

# if present, source the ROS setup files
if [ -f /opt/ros/foxy/setup.bash ]; then
    . /opt/ros/foxy/setup.bash 
fi

# if present, add colcon_cd to the list of commands for ROS2
if [ -f /usr/share/colcon_cd/function/colcon_cd.sh ]; then
    . /usr/share/colcon_cd/function/colcon_cd.sh 
    export _colcon_cd_root=~/ros2_install
fi

# This is a place to store all machine-specific settings. Either source the file, or
# create it if it doesn't exist yet.
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
else
    touch ~/.bashrc_local
    printf "# This is a place to store all machine-specific bash settings (all added by Drake Provost).\n\n" >> .bashrc_local
fi

# This launches the VcXsrv X-server automatically for Docker (on WSL2 only)
# (FIXME: This causes delays in vim startup if an X-server is not reachable
if [ "$USER" == "mddmprovost" ]; then
    export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
fi

# This starts docker automatically if in WSL and not already in a container
if [ "$USER" == "mddmprovost" ]; then
    if [ ! -n "$CONTAINER_NAME" ]; then
        if [ -n "`service docker status | grep not`" ]; then
            sudo service docker start
        fi
    fi
fi

# The following sets up some fancy stuff for prompt appearances (stolen from Ryan Lewis @luckierdodge)
Red='\[\e[01;31m\]'
Green='\[\e[01;32m\]'
Yellow='\[\e[01;33m\]'
Blue='\[\e[01;34m\]'
Cyan='\[\e[01;36m\]'
White='\[\e[01;37m\]'
Orange='\[\e[00;33m\]'
Purple='\[\e[00;35m\]'
Reset='\[\e[00m\]'
DarkGreen='\[\e[00;32m\]'
git_branch()
{
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
git_clean()
{
    # If there are unstaged changes to commit, display the branch in a different color
    if [[ $(git status --porcelain) == "" ]]; then
        echo "$Blue.$Blue$(git_branch)"
    else
        echo "$Blue.$Blue$(git_branch)"
    fi
#    if [[ $(git status) == "" ]]; then
#        echo "$Orange.$Green$(git_branch)"
#    else
#        echo "$Orange.$Orange$(git_branch)"
#    fi
}
set_prompt ()
{
    PS1="$Green\u$Green@"
    if [[ -z "$CONTAINER_NAME" ]]; then
        PS1+="$Green\h"
    else
        PS1+="$Green$CONTAINER_NAME$DarkGreen<${DarkGreen}DOCKER$DarkGreen:$DarkGreen\h$DarkGreen>"
    fi
    PS1+="$Reset:$Blue\w"
    if [ -n "$(git_branch)" ]; then
        PS1+="$(git_clean)"
    fi
    PS1+="$Blue $ $Reset"
#    PS1="$Cyan\u$Orange@"
#    if [[ -z "$CONTAINER_NAME" ]]; then
#        PS1+="$Blue\h"
#    else
#        PS1+="$Purple$CONTAINER_NAME$Orange<${Red}DOCKER$Orange:$Blue\h$Orange>"
#    fi
#    PS1+="$Orange($DarkGreen\w"
#    if [ -n "$(git_branch)" ]; then
#        PS1+="$(git_clean)"
#    fi
#    PS1+="$Orange)$Blue: $Reset"
}
PROMPT_COMMAND='set_prompt'
