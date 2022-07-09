#!/bin/bash

DOTFILES=$PWD;
cd $DOTFILES;
cd ..
USER_HOME=$PWD;
$(pacman -Sy);
cd $DOTFILES;

# should add htop
REQUIRED=('neofetch' 'vim' 'xorg' 'picom' 'alacritty' 'firefox' 'lightdm' 'lightdm-webkit2-greeter');
ABSENT=();

echo "Checking installed packages";
for i in ${REQUIRED[@]}; do
	if ! pacman -Qs $i > /dev/null; then
		ABSENT+=($i);
	fi
done

echo "Installation"
for i in ${ABSENT[@]}; do
	echo "Installing $i";
	$(pacman -S $i);
done

echo "Setting up lightdm"
$(systemctl enable lightdm)
cp lightdm.conf /etc/lightdm
echo "Coping config file"
echo "Coping .vimrc"
cp .vimrc $USER_HOME
echo "Installing vim plugins"
$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
echo "Coping neofetch config"
mkdir -p $USER_HOME/.config/neofetch
cp .config/neofetch/config.conf $USER_HOME/.config/neofetch

