#!/bin/bash
# ~/.bashrc
#

# If not running interactively, don't do anything



[[ $- != *i* ]] && return

blue="\e[34m\e[1m"
nc="\e[0m"

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias vpnd='doas protonvpn disconnect'

alias vpnc='doas protonvpn connect -f'

alias reboot='doas reboot' 

alias shut='doas poweroff'

alias dwmc='vim ~/Programs/dwm-6.2/config.def.h && cd /home/jim/Programs/dwm-6.2'

alias dwmmc='doas rm config.h && doas make clean install'

alias dwmcd='cd /home/jim/Programs/dwm-6.2'

alias ping='ping archlinux.org'

alias calendar='/home/jim/Scripts/Calendar/calendar.sh'

alias time='/home/jim/Scripts/time/time.sh'



cd() {
	if [[ "$@" = ..*  ]] && ! [[ "$@" = .. ]]; then
		c=$1;
		count=${#c};
		i=1
		while [ $i -lt $count ];
		do
			command cd ..; 
			((i=i+1)); 
		done
	elif [[ "$@" = .. ]]
		then
			command cd ..
	else
		command cd "$@"
	fi
	ls
}


csd() {
	c=$1; count=${#c}; i=0
	while [ $i -lt $count ]; do command cd ..; ((i=i+1)); done
}



rm() {
	echo Will delete the following:
	for entry in "$@"; do
		if [ -d "$entry" ]; then
			echo -e $blue$entry$nc
		else
			echo $entry
		fi
	done
	while true; do
		read -p "continue? (Y/n) " -s -n 1 delete <&1
		if [ "$delete" = y ] || ! [ -n "$delete" ]; then
			command rm -R "$@"
			echo -e ""
			break
		else
			echo -e ""
			break
		fi
	done
}

vim() {
	if [[ -f "$*" ]]; then
		/usr/bin/vim "$*"
	elif ! [[ -f "$*" ]] && [[ "$*" == *.tex* ]]; then
		touch "$*"
		cp /home/jim/Useful\ Stuff/Latex/template "$*"
		/usr/bin/vim "$*"
	elif ! [[ -f "$*" ]] && ! [[ "$*" == *.tex* ]]; then
		touch "$*"
		/usr/bin/vim "$*"
	fi
}


clock ()
{
	while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}

if [ -f /etc/bash_completion ]; then
	    /etc/bash_completion
fi
complete -cf doas

f() {
	fff "$@"
	cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

shopt -s autocd

neofetch
#source /home/jim/Scripts/fff_conf/fff.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
