# Custom enviroment varibles

export QT_QPA_PLATFORMTHEME=qt5ct
export VISUAL=vim
export EDITOR=vim

# Run xinitrc if inside tty1 and Awesome WM has not yet been executed

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep awesome || startx ~/xinitrc
fi

eval "$(gh completion -s zsh)"
