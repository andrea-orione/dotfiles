#!/bin/bash

DOTFILES=$PWD;
cd $DOTFILES;
cd ..
USER_HOME=$PWD;
$(sudo pacman -Sy);
cd $DOTFILES;

# PACKAGES INSTALLATION {{{
# should add htop
REQUIRED=('neofetch' 'vim' 'neovim' 'firefox' 'sddm' 'base-devel' 'ttf-ubuntu-font-family' 'vlc' 'rhytmbox' 'okular' 'emacs' 'alacritty' 'pipewire' 'alsa-firmware' 'alsa-plugins' 'alsa-utils' 'htop' 'eza' 'firefox' 'code' 'code-features' 'dunst' 'waybar');

echo "Installation";
for i in ${REQUIRED[@]}; do
	echo "Installing $i";
	$(sudo pacman -S $i --needed);
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
AUR_REQUIRED=('lain-git');

for i in ${AUR_REQUIRED[@]}; do
	echo "Installing $i";
	$(yay -S $i --needed);
done

# }}}


# CONFIG FILE PLACING {{{
# lightdm
echo "Setting up sddm";
$(systemctl enable sddm);
# cp lightdm.conf /etc/lightdm;
# cp lightdm-webkit2-greeter.conf /etc/lightdm;

echo "Coping config file";

# vim
echo "Coping .vimrc";
cp .vimrc $USER_HOME/;
echo "Installing vim plugins";
$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim);

# neofetch
echo "Coping neofetch config";
cp -r .config/neofetch $USER_HOME/.config/;

# awsome
echo "Coping awesome config files";
cp -r .config/awesome $USER_HOME/.config/;

echo "Coping alacritty config";
cp -r .config/alacritty $USER_HOME/.config/;

echo "Coping dunst config";
cp -r .config/dunst $USER_HOME/.config/;

echo "Coping emacs config";
cp -r .config/emacs $USER_HOME/.config/;

echo "Coping htop config";
cp -r .config/htop $USER_HOME/.config/;

echo "Coping hyprland config";
cp -r .config/hypr $USER_HOME/.config/;

echo "Coping wallpapers";
cp -r .wallpapers $USER_HOME/;


# }}}
