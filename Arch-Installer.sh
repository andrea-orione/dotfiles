#!/bin/bash

DOTFILES=$PWD;
cd $DOTFILES;
cd ..
USER_HOME=$PWD;
$(pacman -Sy);
cd $DOTFILES;

# PACKAGES INSTALLATION {{{
# should add htop
REQUIRED=('neofetch' 'vim' 'xorg' 'picom' 'alacritty' 'firefox' 'lightdm' 'lightdm-webkit2-greeter', 'base-devel', 'ttf-ubuntu-font-family');
ABSENT=();

echo "Checking installed packages";
for i in ${REQUIRED[@]}; do
	if ! pacman -Qs $i > /dev/null; then
		ABSENT+=($i);
	fi
done

echo "Installation";
for i in ${ABSENT[@]}; do
	echo "Installing $i";
	$(pacman -S $i);
done

echo "Installing yay";
cd $USER_HOME;
$(git clone https://aur.archlinux.org/yay-git.git);
cd yay-git;
$(makepkg -si);
cd $USER_HOME;
rm -r yay-git;
cd $DOTFILES;

$(yay -Sy);
AUR_REQUIRED=('awesome-freedesktop-git', 'lain-git');
AUR_ABSENT=();
for i in ${AUR_REQUIRED[@]}; do
	if ! yay -Qs $i > /dev/null; then
		AUR_ABSENT+=($i);
	fi
done

for i in ${AUR_ABSENT[@]}; do
	echo "Installing $i";
	$(yay -S $i);
done

# }}}


# CONFIG FILE PLACING {{{
# lightdm
echo "Setting up lightdm";
$(systemctl enable lightdm);
cp lightdm.conf /etc/lightdm;
echo "Coping config file";

# vim
echo "Coping .vimrc";
cp .vimrc $USER_HOME;
echo "Installing vim plugins";
$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim);

# neofetch
echo "Coping neofetch config";
mkdir -p $USER_HOME/.config/neofetch;
cp .config/neofetch/config.conf $USER_HOME/.config/neofetch;

# awsome
echo "Coping awesome config files";
cp -r .config/awesome $USER_HOME/.config;


# }}}
