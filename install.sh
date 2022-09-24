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

# Create a temporary directory and store its name in a variable.
TEMPD=$(mktemp -d)

# Exit if the temp directory wasn't created successfully.
if [ ! -e "$TEMPD" ]; then
    >&2 echo "Failed to create temp directory"
    exit 1
fi

# fish
command -v fish >/dev/null || { sudo apt-add-repository ppa:fish-shell/release-3; sudo apt update; sudo apt install fish; }

# cheat.sh
curl https://cht.sh/:cht.sh > "$TEMPD/cht.sh"
chmod +x "$TEMPD/cht.sh"

# drivedlgo
curl -s https://api.github.com/repos/jaskaranSM/drivedlgo/releases/latest |
grep browser_download_url |
grep Linux_$(uname -m) |
cut -d '"' -f 4 | wget -i- -qO- | gunzip > "$TEMPD"/drivedlgo
chmod +x "$TEMPD"/drivedlgo

# batcat
sudo apt install bat &&
[ -f "$TEMPD/bat" ] || ln -s /usr/bin/batcat "$TEMPD/bat"
	
# exa
sudo apt install exa

# fd
sudo apt install fd-find

# fzf
sudo apt install fzf

# gdu
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
chmod +x gdu_linux_amd64
mv gdu_linux_amd64 "$TEMPD/gdu"

# glow
curl -s https://api.github.com/repos/charmbracelet/glow/releases/latest |
grep browser_download_url |
grep linux_$(uname -m) |
cut -d '"' -f 4 | wget -i- -qO- | tar xz --directory "$TEMPD"
chmod +x "$TEMPD"/glow

# has
curl -sL https://git.io/_has | tee "$TEMPD/has" >/dev/null
chmod +x "$TEMPD/has"

# navi
curl -s https://api.github.com/repos/denisidoro/navi/releases/latest |
grep browser_download_url |
grep $(uname -m)-unknown-linux |
cut -d '"' -f 4 | wget -i- -qO- | tar xz --directory "$TEMPD"
chmod +x "$TEMPD"/navi

# procs
curl -s https://api.github.com/repos/dalance/procs/releases/latest |
grep browser_download_url |
grep $(uname -m)-linux |
cut -d '"' -f 4 |
wget -i- -qO- | busybox unzip -
chmod +x procs
mv procs "$TEMPD"

# tldr
curl -o "$TEMPD/tldr" https://raw.githubusercontent.com/raylee/tldr/master/tldr &&
chmod +x "$TEMPD/tldr"

# yt-dlp
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o "$TEMPD/yt-dlp" &&
chmod +x "$TEMPD/yt-dlp"

sudo mv $TEMPD/* /usr/local/bin/

# Make sure the temp directory gets removed on script exit.
trap "exit 1"           HUP INT PIPE QUIT TERM
trap 'rm -rf "$TEMPD"'  EXIT
