#!/usr/bin/env bash

set -xe

sudo apt update
sudo apt install -yyq software-properties-common build-essential cmake \
stow mpv vim jq libarchive-tools rlwrap

# Create a temporary directory and store its name in a variable.
TEMPD=$(mktemp -d)

# Exit if the temp directory wasn't created successfully.
if [ ! -e "$TEMPD" ]; then
    >&2 echo "Failed to create temp directory"
    exit 1
fi

# fish
command -v fish >/dev/null || {
	sudo apt-add-repository ppa:fish-shell/release-3
	sudo apt update
	sudo apt install fish
}

# as-tree
curl -s https://api.github.com/repos/jez/as-tree/releases/latest |
	jq -r '.assets[] | select(.name|match("linux")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/as-tree

# cheat.sh
curl https://cht.sh/:cht.sh > "$TEMPD"/cht.sh
chmod +x "$TEMPD"/cht.sh

# drivedlgo
curl -s https://api.github.com/repos/jaskaranSM/drivedlgo/releases/latest |
	jq -r '.assets[] | select(.name|match("Linux_x86_64")) | .browser_download_url' |
	wget -i- -qO- | gunzip > "$TEMPD"/drivedlgo
chmod +x "$TEMPD"/drivedlgo

# batcat
sudo apt install bat
ln -s $(which batcat) "$TEMPD"/bat

# bottom
curl -L https://github.com/ClementTsang/bottom/releases/latest/download/bottom_x86_64-unknown-linux-gnu.tar.gz | bsdtar x
chmod +x btm && rm -rf completion
mv btm "$TEMPD"

# dust
curl -s https://api.github.com/repos/bootandy/dust/releases/latest |
	jq -r '.assets[] | select(.name|match("x86_64-unknown-linux-gnu")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x
chmod +x dust-*/dust && mv dust-*/dust "$TEMPD" && rm -rf dust-*/

# docker
command -v docker >/dev/null || {
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	sudo usermod -aG docker '$(whoami)'
	sudo systemctl enable docker
	rm get-docker.sh
}
command -v docker-compose >/dev/null || {
	curl -s https://api.github.com/repos/docker/compose/releases/latest |
       jq -r '.assets[] | select(.name|match("linux-x86_64$")) | .browser_download_url' |
       wget -O docker-compose -i -
	chmod +x docker-compose
	mv docker-compose "$TEMPD"
}

# exa
sudo apt install exa

# fd
sudo apt install fd-find
ln -s $(which fdfind) "$TEMPD"/fd

# fzf
sudo apt install fzf

# fx
curl -L https://github.com/antonmedv/fx/releases/latest/download/fx_linux_amd64 -o "$TEMPD"/fx
chmod +x "$TEMPD"/fx

# gdu
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | bsdtar x
chmod +x gdu_linux_amd64
mv gdu_linux_amd64 "$TEMPD"/gdu

# glow
curl -s https://api.github.com/repos/charmbracelet/glow/releases/latest |
	jq -r '.assets[] | select(.name|match("linux_x86_64")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/glow

# has
curl -sL https://git.io/_has | tee "$TEMPD"/has >/dev/null
chmod +x "$TEMPD"/has

# jdupes
curl -s https://api.github.com/repos/jbruchon/jdupes/releases/latest |
	jq -r '.assets[] | select(.name|match("x86-64")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x
chmod +x jdupes-*/jdupes && mv jdupes-*/jdupes "$TEMPD" && rm -rf jdupes-*/

# lazydocker
curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest |
	jq -r '.assets[] | select(.name|match("Linux_x86_64")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/lazydocker

# navi
curl -s https://api.github.com/repos/denisidoro/navi/releases/latest |
	jq -r '.assets[] | select(.name|match("x86_64-unknown-linux")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/navi

# how2, nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r .tag_name)/install.sh | bash
command -v how2 >/dev/null || {
	fisher install jorgebucaran/nvm.fish
	nvm install latest
	npm install -g how2
}

# nnn
curl -s https://api.github.com/repos/jarun/nnn/releases/latest |
	jq -r '.assets[] | select(.name|match("nerd")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/nnn-*

# procs
curl -s https://api.github.com/repos/dalance/procs/releases/latest |
	jq -r '.assets[] | select(.name|match("linux")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/procs

# ripgrep
sudo apt install ripgrep

# topgrade
curl -s https://api.github.com/repos/r-darwish/topgrade/releases/latest |
	jq -r '.assets[] | select(.name|match("linux-musl")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/topgrade

# yt-dlp
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o "$TEMPD"/yt-dlp &&
chmod +x "$TEMPD"/yt-dlp

sudo mv "$TEMPD"/* /usr/local/bin/
sudo rm /usr/local/bin/LICENSE /usr/local/bin/README.md 

# Make sure the temp directory gets removed on script exit.
trap "exit 1"           HUP INT PIPE QUIT TERM
trap 'rm -rf "$TEMPD"'  EXIT
