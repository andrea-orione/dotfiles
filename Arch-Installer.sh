#!/bin/bash

cd ~/dotfiles;
$(pacman -Sy);

# should add htop
REQUIRED=('neofetch' 'vim');
ABSENT=();

echo "Checking installed packages";
for i in ${REQUIRED[@]}; do
	if $(pacman -Qi $i &>/dev/null); then
		ABSENT+=($i);
	fi
done

echo "Installation"
for i in ${ABSENT[@]}; do
	echo "Installing $i";
	$(pacman -S $i);
done

echo "Coping config file"
echo "Coping .vimrc"
$(cp .vimrc $HOME)
echo "Coping neofetch config"
$(mkdir $HOME/.config/neofetch)
$(cp ./config/neofetch/config.config $HOME/.config/neofetch)


