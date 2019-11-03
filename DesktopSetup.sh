#!/bin/bash
# Above is the shabang! which tells the system what shell to use for all the
# following commands. Shahbang is the only comment that does function as one.
# After script complete, must make it executable: chmod +x fileName.sh
# run script with ./ because it tells system where script is, because our
# script is not in the path statement like our other commands, home directory
# is not in the path statement because that is a security risk.

# INSTALL SCRIPT FOR DEBIAN
# Installing some basic system uttilities

cd ~
sudo apt-get update -qq #qq will make it quiet no imput on the screen

#Install despite errors, using default option don't ask me what to do
#sudo apt-get install -yy
#Install software from the repositories
# the \ called an exception says ignore what every character comes after it
# in this case it is ignoring a carriage return which is a newline
# docker-ce docker-ce-cli containerd.io, vim, boostnote, android studio, redshift
# ufw, tcpdump, net-tools tcpdump nmap dig nslookup iptables keepass rsync rclone zsh joplin
# xfce4-appmenu-plugin cuckoo
sudo apt-get install -yy net-tools tcpdump dnsutils nmap iptables vim \
git vlc ufw okular gimp p7zip-full imagemagick keepassxc wireshark \
clamav clamav-daemon virtualbox virtualbox-ext-pack cups neovim zsh tmux \


sudo dpkg-reconfigure wireshark-common
sudo adduser $USER wireshark

# Enable Cups After start locate at localhost:631
sudo systemctl enable cups
#sudo systemctl start cups

# Docker
sudo apt-get update
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update
apt-cache policy docker-ce
read -p "Notice the above version of docker, press enter to install"

sudo apt-get install docker-ce

# Docker-Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
#Install programs from online
# sudo dpkg -i /path/file
# sudo apt-get install -f
# Modify grub: sudo nano /etc/default/grub
# Configure lightdm to save username: sudo nano /usr/share/lightdm/lightdm/conf.d/01_my.conf
# insert: [SeatDefaults] greeter-hide-users=false
# Make a shortcut to kill application: alt + ctl + esc
cd /home/marvin/Downloads

# NVM to use coc.nvim
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

# Albert
wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/Debian_Testing/Release.key -O Release.key
sudo apt-key add - <Release.key
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/Debian_Testing/ /'> /etc/apt/sources.list.d/home:manuelschneid3r.list
sudo apt-get update
sudo apt-get install albert
# Timeshift
wget "https://github.com/teejee2008/timeshift/releases/download/v19.08.1/timeshift_19.08.1_amd64.deb"
sudo dpkg -i ./timeshift_19.08.1_amd64.deb
sudo apt-get install -f
rm -f ./timeshift_19.08.1_amd64.deb
cd ~

# Set zsh as default shell
chsh -s /bin/zsh
echo "All done! Please reboot the computer"
