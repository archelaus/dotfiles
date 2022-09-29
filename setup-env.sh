#!/usr/bin/env bash
set -e

SELF=$(basename $0)
SELFDIR=$(readlink -f $(dirname $0))

source perl/.perlenv
PATH=$HOME/.local/bin:$PATH

set +e

# Cleanup all old legacy stuf first
for i in $(find $HOME -maxdepth 1 -type l);
do
    found=$(readlink -e $i)
    if [ -z $found ]
    then
        echo "Unable to find $i"
        rm $i
    fi
done

set -e

for i in .profile .bashrc .zshrc .xscreensaverrc
do
    [ -f "$HOME/$i" ] && rm "$HOME/$i"
done

stow stow \
  x11 \
  zsh \
  vim \
  scripts \
  apps \
  perl \
  git

