# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

doas loadkeys .config/loadkeys/loadkeysrc

export BROWSER="firefox"
export TERMINAL="st"

[ "$(tty)" = "/dev/tty1" ] && startx
