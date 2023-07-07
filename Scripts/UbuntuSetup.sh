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
sudo snap install code --classic

curl -sSl https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info | tic -x -
flatpak install flathub com.logseq.Logseq

sudo apt install -yy curl wget caffeine mercurial make binutils bison gcc build-essential xclip wl-clipboard libssl-dev python3-venv kdiff3 nfs-common

echo "Installing Docker docs.docker.com/engine/install/ubuntu"
sudo apt install ca-certificates curl gnupg
echo "Set ZSH default============"
sudo chsh -s $(which zsh)

echo "========= Installing GVM =========="
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

echo "========= Installing LunarVim ========="
zsh <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# FTP (run with docker-compose up -d)
echo "========= Downloading Filestash ========="
mkdir ~/filestash && cd ~/filestash
curl -O https://downloads.filestash.app/latest/docker-compose.yml
cd ~

# Virtualbox
# apt-key was deprecated so do this https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
wget -qO- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
# download and install the pack
wget https://download.virtualbox.org/virtualbox/7.0.8/Oracle_VM_VirtualBox_Extension_Pack-7.0.8.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.8.vbox-extpack
# virtualbox guest additions
sudo apt install build-essential dkms linux-headers-$(uname -r)

# Delete Virtualbox
# sudo apt remove virtualbox virtualbox-*

#
# Install Flatpak
echo "========= Installing Flatpaks ========="
# sudo apt --fix-broken install
sudo apt update
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

flatpak install -y  com.google.Chrome
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
