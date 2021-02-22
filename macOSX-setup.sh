#!/usr/bin/env bash

brew install ctags tmux tree httpie

brew install --cask robo-3t

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
brew install --cask maccy
brew install pandoc lynx
# Instal Mongo: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/
