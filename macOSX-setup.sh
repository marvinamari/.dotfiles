#!/usr/bin/env bash

# brew install ctags ripgrep tree httpie handbrake koekeishiya/formulae/yabai
# brew install --HEAD neovim
# brew install --cask robo-3t kitty

# Install Eclipse for Enterpise Java Developers + Add C++ support

#SDKMan
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
ln -s ~/.sdkman ~/sdkman

brew install --cask alacritty kdiff3 maccy visual-studio-code yarn
# Instal Mongo: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/

brew update&& brew install golang zellij poetry magic-wormhole
mkdir -p $HOME/go/{bin,src,pkg}
