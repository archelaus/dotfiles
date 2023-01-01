#!/usr/bin/env bash

selected=$(cat ~/.config/tmux/tmux-cht-languages ~/.config/tmux/tmux-cht-command |
  fzf-tmux -r)

if [[ -z $selected ]]; then
  exit 0
fi

if grep -qs "$selected" ~/.config/tmux/tmux-cht-languages; then
  read -p "Enter query: " query
  tmux neww -n cht.sh bash -c "cht.sh $selected $query | less -r"
else
  tmux neww -n cht.sh bash -c "cht.sh $selected | less -r"
fi
