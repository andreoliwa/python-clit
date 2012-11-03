#!/bin/bash
V_INSIDE_VIRTUAL_MACHINE=
[[ $HOSTNAME == vm*folha.com.br ]] || [ $HOSTNAME = 'honshu.folha.com.br' ] && V_INSIDE_VIRTUAL_MACHINE=1

function _bash_utils_git_parse_branch {
	# http://www.jonmaddox.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
	echo $(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
}

function _bash_utils_git_titlebar {
	if [ -n "$(_bash_utils_git_parse_branch)" ] ; then
		echo git $(basename "$PWD") $(_bash_utils_git_parse_branch)
	else
		echo "${PWD}"
	fi
}

# Replaces the built-in command "cd", saving the last used directory
# This will be useful in a remote machine, if you want to restore the last working directory on login
# Got the idea from http://ss64.com/bash/builtin.html
function cd() {
	builtin cd "$@" && echo "$PWD" > ~/.last-pwd
}

# My personal environment variables
if [ -f ~/bin/my-variables ] ; then
	. ~/bin/my-variables
fi

if [ -n "$V_INSIDE_VIRTUAL_MACHINE" ] ; then
	# The colors seem to be different to CentOS
	# I had to define them this way, otherwise the prompt flickers inside the VMs, and the Bash reverse search doesn't work
	export COLOR_BLUE="\[\033[0;34m\]"
	export COLOR_CYAN="\[\033[0;36m\]"
	export COLOR_GRAY="\[\033[1;30m\]"
	export COLOR_GREEN="\[\033[0;32m\]"
	export COLOR_LIGHT_BLUE="\[\033[1;34m\]"
	export COLOR_LIGHT_CYAN="\[\033[1;36m\]"
	export COLOR_LIGHT_GRAY="\[\033[0;37m\]"
	export COLOR_LIGHT_GREEN="\[\033[1;32m\]"
	export COLOR_LIGHT_RED="\[\033[1;31m\]"
	export COLOR_NONE="\[\033[0m\]"
	export COLOR_RED="\[\033[0;31m\]"
	export COLOR_WHITE="\[\033[1;37m\]"
else
	# Ubuntu colors
	export COLOR_BLUE='\e[0;34m'
	export COLOR_CYAN='\e[0;36m'
	export COLOR_GRAY='\e[1;30m'
	export COLOR_GREEN='\e[0;32m'
	export COLOR_LIGHT_BLUE='\e[1;34m'
	export COLOR_LIGHT_CYAN='\e[1;36m'
	export COLOR_LIGHT_GRAY='\e[0;37m'
	export COLOR_LIGHT_GREEN='\e[1;32m'
	export COLOR_LIGHT_RED='\e[1;31m'
	export COLOR_NONE='\e[0m'
	export COLOR_RED='\e[0;31m'
	export COLOR_WHITE='\e[1;37m'
fi

function prompt_elite {
	case $TERM in
	    xterm*|rxvt*)
	        local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
	        ;;
	    *)
	        local TITLEBAR=""
	        ;;
	esac

	local temp=$(tty)
	local GRAD1=${temp:5}
	PS1="$TITLEBAR\
$COLOR_GRAY-$COLOR_CYAN-$COLOR_LIGHT_CYAN(\
$COLOR_CYAN\u$COLOR_GRAY@$COLOR_CYAN\h\
$COLOR_LIGHT_CYAN)$COLOR_CYAN-$COLOR_LIGHT_CYAN(\
$COLOR_CYAN\#$COLOR_GRAY/$COLOR_CYAN$GRAD1\
$COLOR_LIGHT_CYAN)$COLOR_CYAN-$COLOR_LIGHT_CYAN(\
$COLOR_CYAN\$(date +%H%M)$COLOR_GRAY/$COLOR_CYAN\$(date +%d-%b-%y)\
$COLOR_LIGHT_CYAN)$COLOR_CYAN-$COLOR_GRAY-\
$COLOR_LIGHT_GRAY\n\
$COLOR_GRAY-$COLOR_CYAN-$COLOR_LIGHT_CYAN(\
$COLOR_CYAN\$$COLOR_GRAY:$COLOR_CYAN\w\
$COLOR_LIGHT_CYAN)$COLOR_CYAN-$COLOR_GRAY-$COLOR_LIGHT_GRAY "
	PS2="$COLOR_LIGHT_CYAN-$COLOR_CYAN-$COLOR_GRAY-$COLOR_NONE "
}

function _bash_utils_git_prompt {
	case $TERM in
	xterm*)
		TITLEBAR='\[\033]0;$(_bash_utils_git_titlebar)\007\]'
	;;
	*)
		TITLEBAR=""
	;;
	esac

	PS1="${TITLEBAR}${debian_chroot:+($debian_chroot)}${COLOR_LIGHT_GREEN}\u@\h${COLOR_LIGHT_BLUE} \w $COLOR_LIGHT_RED\$(_bash_utils_git_parse_branch)$COLOR_LIGHT_BLUE\n\$\[\033[00m\] "
	PS2='> '
	PS4='+ '
}

# Special treatment for work virtual machines
if [ -n "$V_INSIDE_VIRTUAL_MACHINE" ] ; then
	# Source global definitions
	if [ -f /etc/bashrc ]; then
		. /etc/bashrc
	fi

	TITLEBAR='\[\e]0;\h:${PWD}\a\]'

	# Development VM is green; production VMs are red
	if [[ $HOSTNAME == vm206*folha.com.br ]] ; then
		PS1="${COLOR_LIGHT_GREEN}${TITLEBAR}\u@\h:\W\$${COLOR_NONE} "
	else
		PS1="${COLOR_LIGHT_RED}${TITLEBAR}\u@\h:\W\$${COLOR_NONE} "
	fi

	export GREP_OPTIONS='--exclude=\*.svn\*'
	export MY_LOG_DIRECTORY='/net/odyssey/local/dev_desenvolvedores/19/log/repulse'

	# Safe file deletion for CentOS
	alias rm='rm -i'
else
	_bash_utils_git_prompt

	# Safe file deletion for Ubuntu
	alias rm='rm -Iv'
fi

# User specific aliases and functions
alias la='ls -lah'
alias ll='ls -lh'
alias lr='ls -larh'
alias ls='ls --color=auto'
alias lt='ls -lht'
alias top='top -d .7 -c'
alias grep='grep --color=auto'
alias psgrep='ps aux | grep -v grep | grep -e '^USER' -e '
alias pwd='pwd;pwd -P'

export HISTCONTROL=ignoreboth:ignoCOLOR_redups:erasedups
export HISTSIZE=50000
shopt -s histappend

# Prompt for the MySQL command line client
export MYSQL_PS1="(\u@\h) \d>\_"

if [ -z "$V_INSIDE_VIRTUAL_MACHINE" ] ; then
	# Enables the CONTROL+S shortcut to move forward in an incremental search started with CONTROL+R
	stty -ixon

	# Set PATH so it includes user's private bin if it exists
	if [ -d "$HOME/bin" ] ; then
		export PATH="$HOME/bin:/home/wagner/Dropbox/src/bash-utils:$PATH:/home/wagner/src/local/dev_bin/devqa"
	fi

	# Autocomplete for sudo?
	if [ "$PS1" ] ; then
		complete -cf sudo
	fi

	if [ -f /etc/bash_completion ] && ! shopt -oq posix ; then
		. /etc/bash_completion
	fi
fi