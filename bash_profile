#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


# startx at login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
