# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

## general

# neovim
alias vi='nvim'

alias ll='ls -l'
alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias r='doas xbps-remove -R'
alias q='doas xbps-query -Rs'

## git
alias gpatch='git apply --reject --whitespace=fix -p1'
alias gformat-patch='git format-patch --stdout HEAD^ >'
