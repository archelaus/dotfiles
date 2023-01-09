shopt -s dotglob
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrects cd misspellings
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s histappend     # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash_history"

# Load aliases and shortcuts if existent.
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

bind "TAB:menu-complete" 2>/dev/null
bind "set show-all-if-ambiguous on" 2>/dev/null
bind "set completion-ignore-case on" 2>/dev/null
bind "set menu-complete-display-prefix on" 2>/dev/null
bind '"\e[Z":menu-complete-backward' 2>/dev/null

cdown () {
    N=$1
  while [[ $((--N)) >  0 ]]
    do
        echo "$N" |  figlet -c | lolcat &&  sleep 1
    done
}

eval "$(zoxide init bash)"
eval "$(starship init bash)"

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi
