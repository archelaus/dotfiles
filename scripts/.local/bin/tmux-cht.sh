#!/usr/bin/env bash

selected=$(cat ~/.config/tmux/tmux-cht-languages ~/.config/tmux/tmux-cht-command | \
    fzf --bind 'J:preview-down,K:preview-up' --reverse \
    --preview-window wrap)

if [[ -z $selected ]]; then
    exit 0
fi

if grep -qs "$selected" ~/.config/tmux/tmux-cht-languages; then
    read -p "Enter query: " query
    tmux neww bash -c "cht.sh $selected $query | less -r"
else
    tmux neww bash -c "cht.sh $selected | less -r"
fi
