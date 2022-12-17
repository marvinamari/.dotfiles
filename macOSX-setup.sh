#!/usr/bin/env bash

brew install ctags ripgrep tree httpie handbrake koekeishiya/formulae/yabai
brew install --HEAD neovim
brew install --cask robo-3t kitty

# Install Eclipse for Enterpise Java Developers + Add C++ support

#SDKMan
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
ln -s ~/.sdkman ~/sdkman

#plantUML
brew install libtool
brew link libtool
brew install graphviz
brew link --overwrite graphviz
brew install --cask maccy visual-studio-code
brew install pandoc lynx git-delta bat
# Instal Mongo: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/

brew update&& brew install golang
mkdir -p $HOME/go/{bin,src,pkg}
