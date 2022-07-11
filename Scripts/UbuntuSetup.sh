#!/bin/bash

cd ~
sudo apt-get update -qq #qq will make it quiet no imput on the screen
sudo apt upgrade -y

# ppa
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:appimagelauncher-team/stable
sudo add-apt-repository -y ppa:alexlarsson/flatpak
sudo add-apt-repository -y ppa:hluk/copyq
sudo apt-get update -qq
sudo apt-get install -y flatpak gnome-software-plugin-flatpak
flatpak --version

sudo apt-get install -yy git curl\
                        p7zip-full \
                        wget keepassxc \
                        clamav clamav-daemon \
                        virtualbox \
                        virtualbox-ext-pack zsh \
                        tmux coreutils kdiff3 restic \
                        xmonad copyq desktop-file-utils \
                        kdeconnect ubuntu-restricted-extras \
                        ubuntu-restricted-addons \
                        software-properties-common

echo "Set ZSH default============"
chsh -s $(which zsh)

# Docker
echo "========= Installing Docker ========="
sudo apt install -y lsb-release ca-certificates gnupg apt-transport-https software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qq
sudo apt -y install docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Pyenv
echo "========= Installing Pyenv ========="
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

curl https://pyenv.run | bash

# NVM
echo "========= Installing NVM ========="
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

# Jabba
echo "========= Installing Jabba ========="
export JABBA_VERSION=...
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh

# Install rust
echo "========= Installing Rust ========="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable
eval "$(cat ~/.bashrc | tail -n +10)"

# Alacritty
echo "========= Installing Alacritty ========="
sudo apt-get install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev

git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release
sudo cp target/release/alacritty /usr/local/bin #setup desktop entry
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg #add desktop icon
sudo desktop-file-install extra/linux/Alacritty.desktop #add desktop entry
sudo update-desktop-database #update desktop database
sudo mkdir -p /usr/local/share/man/man1 #install man pages
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
cd ~

# Helix
echo "========= Installing Helix ========="
git clone https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term
hx --grammar fetch
hx --grammar build
cd ~

# Cerebro
echo "========= Installing Cerebro ========="
wget https://github.com/cerebroapp/cerebro/releases/download/v0.5.0/cerebro_0.5.0_amd64.deb
sudo dpkg -i cerebro_0.5.0_amd64.deb

# FTP (run with docker-compose up -d)
echo "========= Downloading Filestash ========="
mkdir ~/filestash && cd ~/filestash
curl -O https://downloads.filestash.app/latest/docker-compose.yml
cd ~

# Install Flatpak
echo "========= Installing Flatpaks ========="
# sudo apt --fix-broken install
sudo apt-get update
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

flatpak install -y  com.google.Chrome
flatpak install -y  flathub com.visualstudio.code
flatpak install -y  flathub io.dbeaver.DBeaverCommunity
flatpak install -y  flathub com.discordapp.Discord
flatpak install -y  flathub com.slack.Slack
flatpak install -y  flathub org.flameshot.Flameshot
flatpak install -y  flathub md.obsidian.Obsidian
flatpak install -y  flathub com.obsproject.Studio
flatpak install -y  flathub org.videolan.VLC
flatpak install -y  flathub com.getmailspring.Mailspring

# AppImage Launcher
echo "========= Installing AppImage Launcher ========="
sudo apt -y install appimagelauncher

echo "All done! Please reboot the computer"
echo "Reloud zshrc and set a few things"
echo "pyenv install -v 3.11-dev
nvm install 17.8.0
nvm use 17.8.0
pip install bpytop
jabba ls-remote
sudo usermod -aG docker \${USER}
newgrp docker"
