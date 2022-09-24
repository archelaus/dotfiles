#!/usr/bin/env bash

set -xe

if type apt &> /dev/null; then
	PM=apt
	sudo apt update
	sudo apt install -yyq software-properties-common build-essential cmake stow mpv vim
elif type yum &> /dev/null; then
	PM=yum
	sudo yum update
	sudo yum install git stow mpv vim
else
	echo "What linux is this"
	exit 1
fi

PATH_DIR="${HOME}/.local/bin"
[ -d "$PATH_DIR" ] || mkdir -p "$PATH_DIR"

# fish
command -v fish >/dev/null || { sudo apt-add-repository ppa:fish-shell/release-3; sudo apt update; sudo apt install fish; }

# cheat.sh
curl https://cht.sh/:cht.sh > "$PATH_DIR/cht.sh"
chmod +x "$PATH_DIR/cht.sh"

# batcat
sudo apt install bat &&
[ -f "$PATH_DIR/bat" ] || ln -s /usr/bin/batcat "$PATH_DIR/bat"
	
# exa
curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep browser_download_url | grep linux-$(uname -m)-v | cut -d '"' -f 4 | wget -i- -qO- | busybox unzip - 
mv ./bin/exa "$PATH_DIR/exa" &&
rm -rf completions man bin
chmod +x "$PATH_DIR/exa"

# fd
sudo apt install fd-find

# fzf
sudo apt install fzf

# gdu
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
chmod +x gdu_linux_amd64
mv gdu_linux_amd64 "$PATH_DIR/gdu"

# has
curl -sL https://git.io/_has | tee "$PATH_DIR/has" >/dev/null
chmod +x "$PATH_DIR/has"

# tldr
curl -o "$PATH_DIR/tldr" https://raw.githubusercontent.com/raylee/tldr/master/tldr &&
chmod +x "$PATH_DIR/tldr"

# yt-dlp
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o "$PATH_DIR/yt-dlp" &&
chmod a+rx "$PATH_DIR/yt-dlp"
