#!/bin/bash
# ~/.bashrc
#

# If not running interactively, don't do anything



[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias vpnd='sudo protonvpn disconnect'

alias vpnc='sudo protonvpn connect -f'

alias reboot='sudo reboot now'

alias shut='sudo shutdown now'

alias dwmc='vim ~/Programs/dwm-6.2/config.def.h && cd /home/jim/Programs/dwm-6.2'

alias dwmmc='sudo rm config.h && sudo make clean install'

alias dwmcd='cd /home/jim/Programs/dwm-6.2'

alias ping='ping archlinux.org'

alias calendar='/home/jim/Scripts/Calendar/calendar.sh'

alias time='/home/jim/Scripts/time/time.sh'


cd () {
	if [[ "$@" = ..*  ]] && ! [[ "$@" = .. ]]
	then
		c=$1; count=${#c}; i=1
		while [ $i -lt $count ]; do command cd ..; ((i=i+1)); done
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
	read -rp 'Deleting. Are you sure? (y/n): ' delete
	if [[ $delete == "y" ]]; then
		 /usr/bin/rm -r "$@"
	fi
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
complete -cf sudo

f() {
	fff "$@"
	cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

shopt -s autocd
#source /home/jim/Scripts/fff_conf/fff.sh
