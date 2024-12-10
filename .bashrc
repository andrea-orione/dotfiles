###    ____     ____
###  /  __  \ /  __  \
### |  |__|  |  |  |  |  Andrea Orione
### |   __   |  |  |  |  https://www.github.com/andrea-orione
### |  |  |  |  |__|  |
### |__|  |__|\ ____ /

### Bash configuration

# SET MANPAGER
export MANPAGER="nvim +Man!"    #neovim
# export MANPAGER="less"          #less
export PLUTO_DIR="$HOME/Appunti/gPLUTO"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


### PROMPT
# Commented out because using starship
# PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


### PATH
# The path variable corrispondes to where the system will search the programs
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

# remove safer
alias rm='rm -I'

# file listing
alias ls='eza --color=auto'
alias ll='eza -la --color=always --group-directories-first'
alias lt='eza -la --color=always --group-directories-first --tree'

# file displaying
alias bat='cat'

# common typos
alias tumx='tmux'

# neovim shortcut
alias vim='nvim'

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

# Use the up and down arrow keys for finding a command in history
# (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
# ignore upper and lowercase when TAB completion is used
bind "set completion-ignore-case on"

# Sourcing useful stuff
. "$HOME/.cargo/env"
if [ ! -d "$HOME/.bash_completion/" ]; then
    mkdir -p "$HOME/.bash_completion/"
fi
if [ ! -f "$HOME/.bash_completion/alacritty" ]; then
    touch "$HOME/.bash_completion/alacritty"
fi
source $HOME/.bash_completion/alacritty

eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init --cmd cd bash)"
