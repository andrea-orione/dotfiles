#!/bin/bash

DOTFILES=$PWD;

echo "Installing low level packages"
sudo pacman -S git vim networkmanager sudo base-devel bash-completion\
 eza htop --needed;
systemctl enable networkmanager;


echo "Installing desktop environment packages"
sudo pacman -S pipewire alsa-firmware alsa-plugins alsa-utils\
 bluez bluez-utils waybar dunst hyprland neofetch neovim\
 ttf-ubuntu-font-family sddm;

echo "Setting up sddm";
systemctl enable sddm;


echo "Installing yay";
cd ~;
$(git clone https://aur.archlinux.org/yay-git.git);
cd yay-git;
$(makepkg -si);
cd ..;
rm -r yay-git;
cd $DOTFILES;

echo "Installing aur packages";
yay -Sy wpaperd breeze-hacked-cursor-theme sddm-theme-mountain-git --needed;


echo "Coping config files";

echo "Coping .vimrc";
cp .vimrc ~/;
echo "Installing vim plugins";
$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim);

echo "Coping neofetch config";
cp -r .config/neofetch ~/.config/;

echo "Coping awesome config files";
cp -r .config/awesome ~/.config/;

echo "Coping alacritty config";
cp -r .config/alacritty ~/.config/;

echo "Coping dunst config";
cp -r .config/dunst ~/.config/;

echo "Coping htop config";
cp -r .config/htop ~/.config/;

echo "Coping hyprland config";
cp -r .config/hypr ~/.config/;

echo "Coping wpaperd config";
cp -r .config/wpaperd ~/.config/;

echo "Coping waybar config";
cp -r .config/waybar ~/.config/;

echo "Coping wallpapers";
cp -r .wallpapers ~/;
# }}}


echo "Installing applications"
sudo pacman -S vlc rhythmbox blender gimp musescore shotcut freecad\
  deja-dup duc libreoffice-fresh okular calibre\
  emacs alacritty root code code-features texstudio\
  gnucash keepassxc geogebra firefox qalculate-qt supertux

echo "Coping emacs config";
cp -r .config/emacs ~/.config/;
