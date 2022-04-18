#Sublime text symmlink
#ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

# Theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

source ~/.alias
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# vi mode
bindkey -v

# Alias
source ~/.alias

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

rmd () {
  pandoc $1 | lynx -stdin
}

# Increase file count for "too many files open" error
ulimit -n 10240

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ "$OSTYPE" == "darwin"* ]]; then
    # When running MACOS
    # Kitty Configuration
    autoload -Uz compinit
    compinit
    # Completion for kitty
    kitty + complete setup zsh | source /dev/stdin
    #Ruby
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
    export PATH="/usr/local/opt/ruby/bin:$PATH"
fi

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
