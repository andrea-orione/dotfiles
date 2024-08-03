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

# file listing
alias ls='eza --color=auto'
alias ll='eza -la --color=always --group-directories-first'
alias lt='eza -la --color=always --group-directories-first --tree'
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
alias la='ls -CF'

# common typos
alias tumx='tmux'

# neovim shortcut
alias vim='nvim'

# git bare for config files
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# pacman and yay TODO: change to paru
alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'             # update only AUR pkgs (paru)
alias yaysyu='yay -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)

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

if [ -d "$HOME/.emacs.d/bin" ] ;
  then PATH="$HOME/.emacs.d/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -d "/var/lib/flatpak/exports/bin/" ] ;
  then PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi

if [ -d "$HOME/.config/emacs/bin/" ] ;
  then PATH="$HOME/.config/emacs/bin/:$PATH"
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

### ARCHIVE EXTRACTION
# usage: extract <file>
extract ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### SHELL INTEGRATION
[[ "$(whoami)" = "root" ]] && return
. "$HOME/.cargo/env"

eval "$(starship init zsh)"
fastfetch



bindkey -v
