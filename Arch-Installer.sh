#!/bin/bash

DOTFILES=$PWD;

echo "Enabling scripts"
chmod u+x .bin/*

echo ""
.bin/sync-minimal

echo ""
.bin/sync-coding


if ! $(paru --version &> /dev/null)
then
    echo ""
    echo "Installing paru";
    cd $HOME;
    $(git clone https://aur.archlinux.org/paru.git)
    cd paru
    $(makepkg -si)
    cd ..;
    sudo rm -r paru;
    cd $DOTFILES;
fi


echo ""
.bin/sync-de


echo ""
echo "Setting up sddm";
systemctl enable sddm;


echo ""
echo "Creating config file structure before symlinking"
mkdir "~/.vim"
mkdir -p "~/.vim/pack/themes/start"
mkdir -p "~/.config/emacs"
touch "~/.config/emacs/custom.el"
mkdir -p "~/.config/tmux"
mkdir -p "~/.config/nvim"
mkdir -p "~/.icons"
mkdir -p "~/.themes"
mkdir -p "~/.bin"

echo "Symlinking config files";
stow .
cp .gitconfig ~/


TPM_DIR=$HOME/.tmux/plugins/tpm;
if [ ! -d $TPM_DIR ]
then
    echo ""
    echo "Installing tpm";
    $(git clone https://github.com/tmux-plugins/tpm $TPM_DIR)
fi


echo ""
.bin/sync-prog-lib

echo ""
.bin/sync-app


echo ""
echo "Setting zsh as the default shell"
chsh -s /bin/zsh $USERNAME
