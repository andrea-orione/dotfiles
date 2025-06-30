#!/bin/bash

echo "Installing coding packages"
sudo pacman -S\
    eza zoxide bat\
    lazygit git-delta\
    btop tmux zsh starship fastfetch\
    tree-sitter-cli\
    neovim\
    luarocks hyprlang\
    --needed --noconfirm
