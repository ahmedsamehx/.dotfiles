# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# === Prompt: use default in non-st, custom "~ >" inside st ===
# dark red RGB 170;62;43 (truecolor) with 256-color fallback
if [ "$TERM" = "st-256color" ]; then
  # Colors from your st color scheme
  FOLDER_COLOR="\[\e[1;38;2;125;174;163m\]"  # #d4be98 (bold warm beige)
  ARROW_COLOR="\[\e[1;38;2;234;105;98m\]"    # #ea6962 (bold red)
  RESET="\[\e[0m\]"

  # Bold folder name + bold arrow
  PS1="${FOLDER_COLOR}\W ${ARROW_COLOR}> ${RESET}"
else
  # Default for non-st terminals
  PS1='[\u@\h \W]\$ '
fi





## general

alias ls='ls --color=auto'

# neovim
alias vi='nvim'

alias ll='ls -al'
alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias r='doas xbps-remove -R'
alias q='doas xbps-query -Rs'

## git
alias gpatch='git apply --reject --whitespace=fix -p1'
alias gformat-patch='git format-patch --stdout HEAD^ >'

set -o vi
