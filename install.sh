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

# bottom
curl -L https://github.com/ClementTsang/bottom/releases/latest/download/bottom_x86_64-unknown-linux-gnu.tar.gz | tar xz
chmod +x btm && rm -rf completion
mv btm "$TEMPD"
	
# dust
curl -s https://api.github.com/repos/bootandy/dust/releases/latest |
grep browser_download_url |
grep $(uname -m)-unknown-linux-gnu |
cut -d '"' -f 4 | wget -i- -qO- | tar xz
chmod +x dust-*/dust && mv dust-*/dust "$TEMPD" && rm -rf dust-*/

# docker
command -v docker >/dev/null || {
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	sudo usermod -aG docker "$(whoami)"
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

# fzf
sudo apt install fzf

# fx
curl -L https://github.com/antonmedv/fx/releases/latest/download/fx_linux_amd64 -o fx
chmod +x fx
mv fx "$TEMPD"

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

# ripgrep
sudo apt install ripgrep

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
