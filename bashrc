#
# ~/.bashrc
#

# If not running interactively, don't do anything

#!/bin/bash


[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias vpnd='sudo protonvpn disconnect'

alias vpnc='sudo protonvpn connect -f'

alias reboot='sudo reboot now'

alias shut='sudo shutdown now'

alias dwmc='vim ~/Programs/dwm-6.2/config.def.h && cdl /home/jim/Programs/dwm-6.2'

alias dwmmc='sudo rm config.h && sudo make clean install'

alias dwmcd='cdl /home/jim/Programs/dwm-6.2'

alias ping='ping archlinux.org'

alias remind='/home/jim/Scripts/Reminder/reminder.sh'


cdl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null; ls --color=auto
	else
		echo "bash: cdl: $dir: Directory not found"
	fi
}


csd() {
	c=$1; count=${#c}; i=0
	while [ $i -lt $count ]; do cd ..; ((i=i+1)); done
}


rm() {
	files=("$@")
	if ! [[ -d ${files[*]} ]]; then
		read -rp $"Deleting ${files[*]}. Are you sure? (y/n): " delete
		if [[ $delete == "y" ]]; then
			rmdir "${files[@]}"
		fi
	else
		read -rp $"Deleting ${files[*]}. Are you sure? (y/n): " delete
		if [[ $delete == "y" ]]; then
			for i in "${files[@]}"; do unlink "$i"; done
		fi
	fi
}


clock ()
{
	while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}
