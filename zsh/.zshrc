#Sublime text symmlink
#ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

source ~/.alias

# Path
export PATH=/usr/local/sbin:$PATH

# Enable colors and change prompt:
autoload -U colors && colors
export COLORTERM=truecolor

# History in cache directory:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history

# Environment Vars
#export VIRTUAL_ENV="$HOME/neovim/debug/python/debugpy"
export E="/Volumes/Nvme SSD"
export EHOME=$E/$HOME

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select

# Auto complete with case insensitivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=*r:|=*''l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Key-bindings
bindkey -s '^o' 'ranger^M'
bindkey -s '^f' 'zi^M'
bindkey -s '^s' 'ncdu^M'
# bindkey -s '^n' 'nvim $(fzf)^M'
# bindkey -s '^v' 'nvim\n'
bindkey -s '^z' 'zi^M'
bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
bindkey -r "^u"
bindkey -r "^d"

# FZF
# TODO update for mac
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"
# export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
compinit

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# Environment variables set everywhere
export EDITOR="hx"
export VISUAL="$EDITOR"
export BROWSER="chrome"

# For QT Themes
export QT_QPA_PLATFORMTHEME=qt5ct]]

rmd () {
  pandoc $1 | lynx -stdin
}

# Increase file count for "too many files open" error
ulimit -n 10240

# GO
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

export PATH="$PATH:/home/marvin/.local/share/lvim/distant.nvim/bin"
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
#if [[ "$OSTYPE" == "darwin"* ]]; then
    # When running MACOS
    # Kitty Configuration
    #autoload -Uz compinit
    #compinit
    # Completion for kitty
    #kitty + complete setup zsh | source /dev/stdin
    #Ruby
    #export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
    #export PATH="/usr/local/opt/ruby/bin:$PATH"
#fi

# dotnet
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:/home/marvin/.dotnet"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi
