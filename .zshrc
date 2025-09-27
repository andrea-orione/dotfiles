###    ____     ____
###  /  __  \ /  __  \
### |  |__|  |  |  |  |  Andrea Orione
### |   __   |  |  |  |  https://www.github.com/andrea-orione
### |  |  |  |  |__|  |
### |__|  |__|\ ____ /

### Zsh configuration

### ZINIT AND PLUGINS
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
export PLUTO_DIR="$HOME/Appunti/gPLUTO"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Keybindings
bindkey -v #Set vim mode
bindkey -r ""
bindkey -r ""
bindkey -r ""
bindkey -r "^J"
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Completion settings
autoload -U compinit && compinit
HISTSIZE=1000
HISTFILE=~/.histfile
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion stiling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # match case usensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # color completions
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

### ALIASES
# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# safer remove
alias rm='rm -I'
alias rr='~/.bin/safe-remove-dir.sh'

# file listing
alias ls='eza --color=auto'
alias ll='eza -la --color=always --group-directories-first'
alias lt='eza -la --color=always --group-directories-first --tree'

# file displaying
alias cat='bat'

# neovim shortcut
# alias vim='nvim'

### VARIABLES
# manpager
export MANPAGER="nvim +Man!"    #neovim
# export MANPAGER="less"          #less

# Path
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Programs" ] ;
  then PATH="$HOME/Programs:$PATH"
fi

### SETTING OTHER ENVIRONMENT VARIABLES
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi


### SHELL INTEGRATION
[[ "$(whoami)" = "root" ]] && return
. "$HOME/.cargo/env"

eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
fastfetch
