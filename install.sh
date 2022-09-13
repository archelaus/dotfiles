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

PATH_DIR="~/.local/bin"
[ -d "$PATH_DIR" ] || mkdir -p "$PATH_DIR"

# fish
sudo apt-add-repository ppa:fish-shell/release-3 &&
sudo apt update &&
sudo apt install fish

# cheat.sh
curl https://cht.sh/:cht.sh > "$PATH_DIR/cht.sh"
chmod +x "$PATH_DIR/cht.sh"

# batcat
sudo apt install bat &&
ln -s /usr/bin/batcat "$PATH_DIR/bat"

# exa
curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep browser_download_url | grep linux-$(uname -m)-v | cut -d '"' -f 4 | wget -i- -qO- | busybox unzip - 
mv ./bin/exa "$PATH_DIR/exa" &&
rm -rf completions man bin

# fd
sudo apt install fd-find

# fzf
sudo apt-get install fzf

# has
curl -sL https://git.io/_has | tee "$PATH_DIR/has" >/dev/null

# how2
npm install -g how2

# tldr
curl -o "$PATH_DIR/tldr" https://raw.githubusercontent.com/raylee/tldr/master/tldr &&
chmod +x "$PATH_DIR/tldr"

# yt-dlp
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o "$PATH_DIR/yt-dlp" &&
chmod a+rx "$PATH_DIR/yt-dlp"
