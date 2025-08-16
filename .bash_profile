# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

doas loadkeys .config/loadkeys/loadkeysrc

export BROWSER="brave-browser"
export TERMINAL="st"
export PATH="$HOME/bin:$PATH"

[ "$(tty)" = "/dev/tty1" ] && startx
