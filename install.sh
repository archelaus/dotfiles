#!/usr/bin/env bash

set -xe

if type apt-get &> /dev/null; then
	PM=apt-get
	sudo apt-get update
	sudo apt-get install -yyq software-properties-common build-essential cmake stow mpv vim
elif type yum &> /dev/null; then
	PM=yum
	sudo yum update
	sudo yum install git stow mpv vim
else
	echo "What linux is this"
	exit 1
fi


# [ -d "~/.local/bin" ] || mkdir -p ~/.local/bin

# yt-dlp
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
