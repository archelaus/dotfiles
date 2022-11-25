#!/usr/bin/env bash

# Consider Starting All Your Bash Scripts with These Options.
# https://medium.com/factualopinions/consider-starting-all-your-bash-scripts-with-these-options-74fbec0cbb83
set -euo pipefail

if ! command -v systemctl >/dev/null 2>&1; then
    echo "> Sorry but this script is only for Linux with systemd, eg: Ubuntu 16.04+/Centos 7+ ..."
    exit 1
fi

# OSARCH=$(uname -m)
# case $OSARCH in 
#     x86_64)
#         BINTAG=Linux_x86_64
#         ;;
#     i*86)
#         BINTAG=Linux_i386
#         ;;
#     arm64)
#         BINTAG=Linux_arm64
#         ;;
#     arm*)
#         BINTAG=Linux_armv6
#         ;;
#     *)
#         echo "unsupported OSARCH: $OSARCH"
#         exit 1
#         ;;
# esac

# if [[ $(id -u) -ne 0 ]]; then
#    echo "This script must be run as root" 
#    exit 1
# fi

set -x
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

# anypaste
curl -Lo "$TEMPD"/anypaste https://anypaste.xyz/sh

# atuin
curl -s https://api.github.com/repos/ellie/atuin/releases/latest |
	jq -r '.assets[] | select(.name|match("linux")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x
chmod +x atuin-*/atuin && mv atuin-*/atuin "$TEMPD" && rm -rf atuin-*/

# batcat
sudo apt install bat
ln -s $(which batcat) "$TEMPD"/bat

# cheat.sh
curl https://cht.sh/:cht.sh > "$TEMPD"/cht.sh
chmod +x "$TEMPD"/cht.sh

# d-fi
curl -sL https://github.com/d-fi/releases/releases/latest/download/d-fi-linux.zip | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/d-fi

# dict
curl -sL https://github.com/BetaPictoris/dict/releases/latest/download/dict -o "$TEMPD"/dict
chmod +x "$TEMPD"/dict

# drivedlgo
curl -sL https://api.github.com/repos/jaskaranSM/drivedlgo/releases/latest |
	jq -r '.assets[] | select(.name|match("Linux_x86_64")) | .browser_download_url' |
	wget -i- -qO- | gunzip > "$TEMPD"/drivedlgo
chmod +x "$TEMPD"/drivedlgo

# dust
curl -s https://api.github.com/repos/bootandy/dust/releases/latest |
	jq -r '.assets[] | select(.name|match("x86_64-unknown-linux-musl")) | .browser_download_url' |
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
curl -sL https://github.com/antonmedv/fx/releases/latest/download/fx_linux_amd64 -o "$TEMPD"/fx
chmod +x "$TEMPD"/fx

# go-upload
curl -sL https://github.com/Sorrow446/go-upload/latest/download/go-ul_linux_x64 -o "$TEMPD"/go-ul
chmod +x "$TEMPD"/go-ul

# gdu
curl -sL https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | bsdtar x
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

# lazygit
curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest |
	jq -r '.assets[] | select(.name|match("Linux_x86_64")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/lazygit

# lazydocker
curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest |
	jq -r '.assets[] | select(.name|match("Linux_x86_64")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/lazydocker

# navi
curl -s https://api.github.com/repos/denisidoro/navi/releases/latest |
	jq -r '.assets[] | select(.name|match("linux-musl")) | .browser_download_url' |
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
	wget -i- -qO- | bsdtar x
chmod +x nnn-* && mv nnn-* "$TEMPD"/nnn

# pipx
python3 -m pip install --user pipx

# procs
curl -s https://api.github.com/repos/dalance/procs/releases/latest |
	jq -r '.assets[] | select(.name|match("linux")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/procs

# rclone
curl https://rclone.org/install.sh | sudo bash -s beta || continue

# ripgrep
sudo apt install ripgrep

# topgrade
curl -s https://api.github.com/repos/r-darwish/topgrade/releases/latest |
	jq -r '.assets[] | select(.name|match("linux-musl")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/topgrade

# tv
curl -s https://api.github.com/repos/alexhallam/tv/releases/latest |
	jq -r '.assets[] | select(.name|match("linux-musl")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x
chmod +x tidy-viewer-*/tidy-viewer &&
mv tidy-viewer-*/tidy-viewer "$TEMPD" &&
rm -rf ./tidy-viewer-*/

# yt-dlp
curl -sL https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o "$TEMPD"/yt-dlp &&
chmod +x "$TEMPD"/yt-dlp

sudo mv "$TEMPD"/* /usr/local/bin/
sudo rm /usr/local/bin/LICENSE /usr/local/bin/README.md 

# Make sure the temp directory gets removed on script exit.
trap "exit 1"           HUP INT PIPE QUIT TERM
trap 'rm -rf "$TEMPD"'  EXIT
