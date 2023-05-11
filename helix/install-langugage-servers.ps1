$BINARY_HOME = "${env:HOME}/.local/bin"
Write-Output "Installing Language Servers for Helix Editor:"

# Work in a throwaway temporary directory so as not to pollute the file system.
$temporaryDirectory = "${env:TEMP}/helix-editor-language-server-installer"
New-Item -ItemType Directory -Path $temporaryDirectory -Force | Out-Null
Push-Location $temporaryDirectory

# Bash (https://github.com/bash-lsp/bash-language-server)
Write-Output "  • Bash (bash-language-server)"
npm list -g | Select-String bash-language-server || npm i -g bash-language-server

# SQL (https://github.com/joe-re/sql-language-server)
Write-Output "  • SQL (sql-language-server && sql-formatter)"
npm list -g | Select-String sql-language-server || npm i -g sql-language-server
npm list -g | Select-String sql-formatter || npm i -g sql-formatter

# HTML, JSON, JSON schema (https://github.com/hrsh7th/vscode-langservers-extracted)
Write-Output "  • HTML, JSON, and JSON schema (vscode-langservers-extracted)"
npm list -g | Select-String vscode-langservers-extracted || npm i -g vscode-langservers-extracted

# JavaScript (via TypeScript: https://github.com/typescript-language-server/typescript-language-server)
Write-Output "  • JavaScript (typescript, typescript-language-server)"
npm list -g | Select-String typescript-language-server || npm install -g typescript typescript-language-server

# Markdown (https://github.com/artempyanykh/marksman)
Write-Output "  • Markdown (ltex-ls)"
brew list | Select-String marksman || brew install marksman

# Python (https://github.com/microsoft/pyright)
Write-Output "  • Pyright"
npm list -g | Select-String pyright || npm install -g pyright

# Black ()
Write-Output "  • Black"
pip list | Select-String black || pip install git+https://github.com/psf/black

# Clean up.
Pop-Location
Remove-Item $temporaryDirectory -Force -Recurse

Write-Output "Done."
