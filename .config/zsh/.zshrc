#~/.config/zsh/.zshrc

setopt no_nomatch

# if not interactive, don't do anything
[[ -o interactive ]] || return

autoload -U colors && colors

# -------- Prompt (truecolor) --------
# Use printf to get a real ESC character and wrap non-printing sequences in %{
if [[ "$TERM" = "st-256color" || "$TERM" = "xterm-256color" ]]; then
  FOLDER_COLOR=$(printf '\033[1;38;2;125;174;163m')   # #7daea3
  ARROW_COLOR=$(printf '\033[1;38;2;234;105;98m')    # #ea6962
  RESET=$(printf '\033[0m')

  # PROMPT_SUBST allows variable expansion inside PROMPT
  setopt PROMPT_SUBST
  PROMPT="%{${FOLDER_COLOR}%}%1~ %{$ARROW_COLOR%}> %{$RESET%}"
else
  PS1='[%n@%m %1~]$ '
fi

# -------- History --------
if [ -f "$HOME/.zsh_history" ]; then
  HISTFILE="$HOME/.zsh_history"
else
  mkdir -p "$HOME/.cache/zsh"
  HISTFILE="$HOME/.cache/zsh/history"
fi
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY SHARE_HISTORY

# -------- Completion --------
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)    # include hidden files in completion

# Run compinit safely (avoid insecure dir warnings)
autoload -Uz compinit
compinit -u 2>/dev/null || compinit 2>/dev/null

# -------- Keybindings & vi mode --------
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in menuselect
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# Backspace behaviour
bindkey -v '^?' backward-delete-char

# Make Delete behave (common sequences)
# Most terminals send \e[3~ for Delete — add alternatives for some terminals.
bindkey '\e[3~' delete-char
bindkey '\177' backward-delete-char  # DEL as 0x7f (fallback)
# some terminals (rare) send other sequences; you can add them as needed
# bindkey '\e[1;2~' delete-char

# -------- Debounced cursor-shape switching (reduce flicker) --------
# Only enable when terminal is likely to support DECSTBM cursor shape.
if [[ "$TERM" = "st-256color" || "$TERM" = "xterm-256color" || "$TERM" = "xterm" ]]; then
  typeset -g __ZSH_CUR_KEYMAP=""

  zle-keymap-select() {
    local km=${KEYMAP:-main}
    [[ $km == $__ZSH_CUR_KEYMAP ]] && return
    __ZSH_CUR_KEYMAP=$km

    if [[ $km == vicmd ]]; then
      printf '\e[1 q' > /dev/tty    # block cursor in command mode
    else
      printf '\e[5 q' > /dev/tty    # beam cursor in insert mode
    fi
  }
  zle -N zle-keymap-select

  zle-line-init() {
    zle -K viins
    printf '\e[5 q' > /dev/tty
  }
  zle -N zle-line-init
fi

# -------- Utilities (lf, edit-line) --------
lfcd() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
bindkey -s '^f' 'lfcd\n'

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# -------- Aliases --------
alias ls='ls --color=auto'
alias ll='ls -al'
alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias r='doas xbps-remove -R'
alias q='doas xbps-query -Rs'
alias vi='nvim'
alias yt='yt-dlp'

# git niceties
alias gpatch='git apply --reject --whitespace=fix -p1'
alias gformat-patch='git format-patch --stdout HEAD^ >'

# small niceties
setopt PROMPT_CR    # clean carriage returns on multiline

# -------- Load user extras and plugins (ordered) --------
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# zsh-autosuggestions (try common locations)
for p in \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh/site-functions/zsh-autosuggestions.zsh \
  /usr/share/zsh/vendor-completions/_zsh-autosuggestions \
  "$HOME/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
  if [ -f "$p" ]; then
    source "$p"
    break
  fi
done

# zsh-history-substring-search (if present)
for p in \
  /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh \
  /usr/share/zsh/site-functions/zsh-history-substring-search.zsh \
  "$HOME/.local/share/zsh-history-substring-search/zsh-history-substring-search.zsh"; do
  if [ -f "$p" ]; then
    source "$p"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
    break
  fi
done

# zsh-completions are provided via fpath earlier — compinit already ran

# zsh-syntax-highlighting MUST be last
for p in \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh \
  "$HOME/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
  if [ -f "$p" ]; then
    source "$p"
    break
  fi
done

# End of cleaned config

