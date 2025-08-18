# ~/.zprofile

# system profile
[[ -f /etc/profile ]] && . /etc/profile

doas loadkeys "$HOME/.config/loadkeys/loadkeysrc" 2>/dev/null || true

# Default programs
export ZDOTDIR="$HOME/.config/zsh"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="brave-browser"
export TERMINAL="st"
export READER="zathura"
export FILE="lf"

export PATH="$HOME/bin:$PATH"

export ZDOTDIR="$HOME/.config/zsh"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

# XDG (اختياري لكن مفيد)
#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_CACHE_HOME="$HOME/.cache"
#export XDG_DATA_HOME="$HOME/.local/share"


[ "$(tty)" = "/dev/tty1" ] && startx

