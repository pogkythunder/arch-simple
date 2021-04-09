#
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

alias dwmc='vim ~/Programs/dwm-6.2/config.def.h'

alias dwmmc='sudo rm config.h && sudo make clean install'

alias dwmcd='cdl /home/jim/Programs/dwm-6.2'

alias ping='ping archlinux.org'

alias rm='pwd; read -p "Press Enter to continue"; rm'

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
