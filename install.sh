#!/usr/bin/env bash

# Consider Starting All Your Bash Scripts with These Options.
# https://medium.com/factualopinions/consider-starting-all-your-bash-scripts-with-these-options-74fbec0cbb83
# set -eou pipefail

if ! command -v systemctl >/dev/null 2>&1; then
    echo "> Sorry but this script is only for Linux with systemd, eg: Ubuntu 16.04+/Centos 7+ ..."
    exit 1
fi

if command -v nala >/dev/null; then
  eapt=nala
else
  eapt=apt
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

sudo $eapt update
sudo $eapt install -y software-properties-common build-essential cmake \
stow mpv jq vim libarchive-tools

for package in gallery-dl gitdir lolcat subliminal trash-cli virtualfish howdoi; do
	pipx install $package
done

# Create a temporary directory and store its name in a variable.
TEMPD=$(mktemp -d)

# Exit if the temp directory wasn't created successfully.
if [[ ! -e $TEMPD ]]; then
    >&2 echo "Failed to create temp directory"
    exit 1
fi

set -x

# # fish
# command -v fish >/dev/null || {
# 	sudo apt-add-repository ppa:fish-shell/release-3
# 	sudo apt update
# 	sudo apt install fish
# }

# as-tree
curl -sL https://api.github.com/repos/jez/as-tree/releases/latest |
	jq -r '.assets[] | select(.name|match("linux")) | .browser_download_url' |
	wget -i- -qO- | bsdtar x -C"$TEMPD"
chmod +x "$TEMPD"/as-tree

# anypaste
curl -sLo "$TEMPD"/anypaste https://anypaste.xyz/sh
chmod +x "$TEMPD"/anypaste

# # atuin
# curl -sL https://api.github.com/repos/ellie/atuin/releases/latest |
# 	jq -r '.assets[] | select(.name|match(".deb")) | .browser_download_url' |
# 	wget --show-progress -qi-
# sudo $eapt install -y atuin_*.deb && rm atuin_*.deb

# # batcat
# sudo $eapt install bat
# ln -s $(which batcat) "$TEMPD"/bat

# # cheat.sh
# curl https://cht.sh/:cht.sh > "$TEMPD"/cht.sh
# chmod +x "$TEMPD"/cht.sh

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

# # dust
# curl -s https://api.github.com/repos/bootandy/dust/releases/latest |
# 	jq -r '.assets[] | select(.name|match("x86_64-unknown-linux-musl")) | .browser_download_url' |
# 	wget -i- -qO- | bsdtar x
# chmod +x dust-*/dust && mv dust-*/dust "$TEMPD" && rm -rf dust-*/

# # docker
# command -v docker >/dev/null || {
# 	curl -fsSL https://get.docker.com -o get-docker.sh
# 	sudo sh get-docker.sh
# 	sudo usermod -aG docker '$(whoami)'
# 	sudo systemctl enable docker
# 	rm get-docker.sh
# }
# command -v docker-compose >/dev/null || {
# 	curl -s https://api.github.com/repos/docker/compose/releases/latest |
#        jq -r '.assets[] | select(.name|match("linux-x86_64$")) | .browser_download_url' |
#        wget -O docker-compose -i -
# 	chmod +x docker-compose
# 	mv docker-compose "$TEMPD"
# }

# # fd
# sudo $eapt install -y fd-find
# ln -s $(which fdfind) "$TEMPD"/fd

# # fzf
# sudo $eapt install -y fzf

# # fx
# curl -sL https://github.com/antonmedv/fx/releases/latest/download/fx_linux_amd64 -o "$TEMPD"/fx
# chmod +x "$TEMPD"/fx

# go-upload
curl -sL https://github.com/Sorrow446/go-upload/latest/download/go-ul_linux_x64 -o "$TEMPD"/go-ul
chmod +x "$TEMPD"/go-ul

# # gdu
# curl -sL https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | bsdtar x
# chmod +x gdu_linux_amd64
# mv gdu_linux_amd64 "$TEMPD"/gdu

# # glow
# curl -s https://api.github.com/repos/charmbracelet/glow/releases/latest |
# 	jq -r '.assets[] | select(.name|match("linux_x86_64")) | .browser_download_url' |
# 	wget -i- -qO- | bsdtar x -C"$TEMPD"
# chmod +x "$TEMPD"/glow

# has
curl -sL https://git.io/_has | tee "$TEMPD"/has >/dev/null
chmod +x "$TEMPD"/has

# how2
curl -sL https://github.com/santinic/how2/releases/latest/download/how2-linux-x64.tar.gz | bsdtar x
mv how2* "$TEMPD"/how2 && chmod +x "$TEMPD"/how2

# # insect
# if command -v insect >/dev/null; then
# 	npm update -g insect
# else
# 	npm install -g insect
# fi

# # jdupes
# curl -s https://api.github.com/repos/jbruchon/jdupes/releases/latest |
# 	jq -r '.assets[] | select(.name|match("x86-64")) | .browser_download_url' |
# 	wget -i- -qO- | bsdtar x
# chmod +x jdupes-*/jdupes && mv jdupes-*/jdupes "$TEMPD" && rm -rf jdupes-*/

# # lazygit
# curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest |
# 	jq -r '.assets[] | select(.name|match("Linux_x86_64")) | .browser_download_url' |
# 	wget -i- -qO- | bsdtar x -C"$TEMPD"
# chmod +x "$TEMPD"/lazygit

# # lazydocker
# curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest |
# 	jq -r '.assets[] | select(.name|match("Linux_x86_64")) | .browser_download_url' |
# 	wget -i- -qO- | bsdtar x -C"$TEMPD"
# chmod +x "$TEMPD"/lazydocker

# # lsd
# curl -s https://api.github.com/repos/Peltoche/lsd/releases/latest |
# 	jq -r '.assets[] | select(.name|match("x86_64-unknown-linux-musl")) | .browser_download_url' |
# 	wget -i- -qO- | bsdtar x
# chmod +x lsd-*/lsd && mv lsd-*/lsd "$TEMPD" && rm -rf lsd-*/

# # how2, nvm
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r .tag_name)/install.sh | bash
# command -v how2 >/dev/null || {
# 	fisher install jorgebucaran/nvm.fish
# 	nvm install latest
# 	npm install -g how2
# }

# ripgrep
# sudo $eapt install ripgrep

# topgrade
curl -s https://api.github.com/repos/topgrade-rs/topgrade/releases/latest |
	jq -r '.assets[] | select(.name|match("x86_64-unknown-linux-musl")) | .browser_download_url' |
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
# curl -sL https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o "$TEMPD"/yt-dlp &&
# chmod +x "$TEMPD"/yt-dlp

# ytdlp
pipx install https://github.com/yt-dlp/yt-dlp/archive/master.tar.gz

set +x

sudo mv "$TEMPD"/* /usr/local/bin/
# sudo rm /usr/local/bin/LICENSE /usr/local/bin/README.md

# Make sure the temp directory gets removed on script exit.
trap "exit 1"           HUP INT PIPE QUIT TERM
trap 'rm -rf "$TEMPD"'  EXIT
