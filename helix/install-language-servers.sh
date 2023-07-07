#!/usr/bin/env bash

BINARY_HOME="${HOME}/.local/bin"

echo "Installing Language Servers for Helix Editor:"

# Work in a throwaway temporary directory so as not to pollute the file system.
temporaryDirectory="/tmp/helix-editor-language-server-installer"
mkdir -p "${temporaryDirectory}"
pushd "${temporaryDirectory}"

# Bash (https://github.com/bash-lsp/bash-language-server)
echo "  • Bash (bash-language-server)"
npm list -g | grep bash-language-server || npm i -g bash-language-server

# SQL (https://github.com/joe-re/sql-language-server)
echo " • SQL (sql-language-server && sql-formatter)" 
npm list -g | grep sql-language-server || npm i -g sql-language-server
npm list -g | grep sql-formatter || npm i -g sql-formatter

# HTML, JSON, JSON schema (https://github.com/hrsh7th/vscode-langservers-extracted)
echo "  • HTML, JSON, and JSON schema (vscode-langservers-extracted)"
npm list -g | grep vscode-langservers-extracted || npm i -g vscode-langservers-extracted

# JavaScript (via TypeScript: https://github.com/typescript-language-server/typescript-language-server)
echo "  • JavaScript (typescript, typescript-language-server)"
npm list -g | grep typescript-language-server || npm install -g typescript typescript-language-server

# Markdown (https://github.com/artempyanykh/marksman)
echo "  • Markdown (ltex-ls)"
brew list | grep marksman || brew install marksman
brew list | grep dotnet || brew install dotnet
brew list | grep omnisharp || brew tap omnisharp/omnisharp-roslyn && brew update && brew install omnisharp

# Python (https://github.com/microsoft/pyright)
echo "  • Pyright"
npm list -g | grep pyright || npm install -g pyright

# Black ()
echo "  • Black"
pip3 list | grep black || pip install git+https://github.com/psf/black

# Clean up.
popd
rm -rf "${temporaryDirectory}"

echo "Done."