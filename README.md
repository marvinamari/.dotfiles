#### Nvim logs
~/.cache/nvim/

# setup
To install activate dotbot by running:
`git submodule update --init`

Install dotfiles
cp dotbot/tools/git-submodule/install .
or
cp dotbot/tools/git-submodule/install.ps1 .

https://github.com/ms-jpq/coq_nvim
Requires install
python virtual env
```
# Ubuntu
apt install --yes python3-venv'
# Pip
pip install virtualenv
```
### TMUX
In copy mode Y will yank the current line:
Once you’ve copied some stuff, you can do more than just paste the last thing:

           #           List all paste buffers.
           -           Delete the most recently copied buffer of text.
           =           Choose which buffer to paste interactively from a list.
           [           Enter copy mode to copy text or view the history.
           ]           Paste the most recently copied buffer of text. 
(I have [ remapped to Escape and ] remapped to p. I use - for split-window -v, so I moved delete-buffer to +.)

tmux remembers old buffers and prefix + = lets you paste them arbitrarily!

Mount external drive:
`https://www.zdnet.com/article/how-to-permanently-mount-a-drive-in-linux-and-why-you-should/`
`https://developerinsider.co/auto-mount-drive-in-ubuntu-server-22-04-at-startup/`
1. Make directory which will be the mount point for drive
`mkdir /mnt/name`
> change ownership of directory to user `sudo chown -R $USER:$USER /mnt/name`
2. Locate the name of your drive
`lsblk -o NAME,FSTYPE,UUID,MOUNTPOINTS`
3. Copy the UUID and file system type
4. Edit fstab
`sudo vim /etc/fstab`
5. Add a new entry of the following format
```
<file system> <mount point>   <type>  <options>       <dump>  <pass>
UUID=<UUID> <PATH_TO_MOUNT> <DRIVE_TYPE>  defaults        0       0

# Example entry for USB1
UUID=632D-7154 /media/USB1   exfat    defaults        0       0
```
6. Before rebooting verify fstab is valid, if not disk may become unbootable
`sudo findmnt --verify`
> If any errors or warnings occur something may be wrong.
7. Reboot and test drive
`lsblk -o NAME,FSTYPE,UUID,MOUNTPOINTS`


Change docker storage location
`evodify.com/change-docker-storage-location`
1. create file `/etc/docker/daemon.json`
2. `sudo systemctl restart docker`
3. `docker system prune -a`

universal c tags
```
# MacOS
brew uninstall ctags           # bad
brew install   universal-ctags # good

# Ubuntu
apt remove  ctags              # bad
apt install universal-ctags    # good
```
Final step to activate coq is running in nvim
:COQdeps
:COQnow

Vim Test requires pynvim
`pip3 instal --user pynvim` or you can just install as root without user flag

When you upgrade neovim upgrade pynvim as well
`pip3 install --upgrade pynvim`

Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

Brew backup restore packages: https://tomlankhorst.nl/brew-bundle-restore-backup/

Binaries for linting:
black, flake8, prettier

Vieew brew tree
`brew deps --tree --installed`


# Set zsh as default shell
# First view list of shells, if bash not listed and you add zsh you might find you can no longer log in as root and bash doesn't work
cat /etc/shells

# add zsh
command -v zsh | sudo tee -a /etc/shells

# now we have told terminal zsh is valid shell login, set as default
sudo chsh -s $(which zsh) $USER


Use asdf to install php which comes with composer

# Install Bitwarden
https://github.com/bitwarden/clients/tree/main/apps/cli

# Download httpie to Applications
