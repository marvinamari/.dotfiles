#!/bin/bash

cd ~
sudo apt update -qq #qq will make it quiet no imput on the screen
sudo apt upgrade -y

# install snapd, flatpak
{
  flatpak --version
} || {
  echo "Installing flatpak..."
  sudo apt install flatpak
}

{
  snapd --version
} || {
  echo "Installing snapd...."
  sudo apt install snapd
}

sudo snapd install keepassxc dbeaver-ce
sudo snap install alacritty --edge --classic
flatpak install flathub com.logseq.Logseq

sudo apt install -yy curl wget

echo "Set ZSH default============"
chsh -s $(which zsh)


# FTP (run with docker-compose up -d)
echo "========= Downloading Filestash ========="
mkdir ~/filestash && cd ~/filestash
curl -O https://downloads.filestash.app/latest/docker-compose.yml
cd ~

# Install Flatpak
echo "========= Installing Flatpaks ========="
# sudo apt --fix-broken install
sudo apt update
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

flatpak install -y  com.google.Chrome
flatpak install -y  flathub com.visualstudio.code
flatpak install -y  flathub com.discordapp.Discord
flatpak install -y  flathub com.slack.Slack
flatpak install -y  flathub org.flameshot.Flameshot
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
sudo usermod -aG docker \${USER}
newgrp docker"
