#!/bin/bash

sudo apt-get update -qq #qq will make it quiet no imput on the screen
sudo apt-get install -yy git \
                        p7zip-full \
                        wget keepassxc \
                        clamav clamav-daemon \
                        virtualbox \
                        virtualbox-ext-pack zsh \
                        tmux coreutils kdiff3 restic xmonad

# ppa
sudo add-apt-repository ppa:appimagelauncher-team/stable
sudo add-apt-repository ppa:hluk/copyq

# Docker
sudo apt-get update
sudo apt install ca-certificates curl gnupg2 lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  (lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Pyenv
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

curl https://pyenv.run | bash
exec "$SHELL"
pyenv install -v 3.11-dev

# NVM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
exec "$SHELL"
nvm install 17.8.0
nvm use 17.8.0

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable

# Alacritty
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev

git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release
sudo cp target/release/alacritty /usr/local/bin #setup desktop entry
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg #add desktop icon
sudo desktop-file-install extra/linux/Alacritty.desktop #add desktop entry
sudo update-desktop-database #update desktop database
sudo mkdir -p /usr/local/share/man/man1 #install man pages
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

# Helix
git clone https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term
hx --grammar fetch
hx --grammar build
cd ~

# Cerebro
wget https://github.com/cerebroapp/cerebro/releases/download/v0.5.0/cerebro_0.5.0_amd64.deb
sudo dpkg -i cerebro_0.5.0_amd64.deb

# Clipboard manager
sudo apt update
sudo apt install copyq

# FTP (run with docker-compose up -d)
mkdir ~/filestash && cd ~/filestash
curl -O https://downloads.filestash.app/latest/docker-compose.yml
cd ~

# Install Flatpak
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo apt-get update -qq
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak install com.google.Chrome
flatpak install flathub com.visualstudio.code
flatpak install flathub io.dbeaver.DBeaverCommunity
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.slack.Slack
flatpak install flathub org.flameshot.Flameshot
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.obsproject.Studio

# AppImage Launcher
sudo apt install appimagelauncher

# Set zsh as default shell
chsh -s /bin/zsh
echo "All done! Please reboot the computer"
