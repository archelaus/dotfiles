#!/usr/bin/env bash

selected=$(cat ~/.config/tmux/tmux-cht-languages ~/.config/tmux/tmux-cht-command |
  fzf-tmux -r)

[[ -z $selected ]] && exit 0

if grep -qs $selected ~/.config/tmux/tmux-cht-languages; then
  tmux neww -n cht.sh bash -c "read -p 'Enter prompt: ' query; cht.sh $selected \$query | less -r"
else
  tmux neww -n cht.sh bash -c "cht.sh $selected | less -r"
fi
