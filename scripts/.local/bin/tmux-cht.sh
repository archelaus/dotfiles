#!/usr/bin/env bash

selected=$(cat ~/.config/tmux/tmux-cht-languages ~/.config/tmux/tmux-cht-command |
  fzf-tmux -p --bind=enter:replace-query+print-query)

[[ -z $selected ]] && exit 0

if grep -Fxq $selected ~/.config/tmux/tmux-cht-languages; then
  tmux neww -n cht.sh bash -c "read -p 'Enter prompt: ' query; clear; \
  curl -s cht.sh/$selected/\${query// /+} | less -r"
else
  if grep -Fxq $selected ~/.config/tmux/tmux-cht-command; then
    tmux neww -n cht.sh bash -c "curl -s cht.sh/$selected | less -r"
  else
    echo $selected >> ~/.config/tmux/tmux-cht-command
    tmux neww -n cht.sh bash -c "curl -s cht.sh/$selected | less -r"
  fi
fi
