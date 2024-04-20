#!/bin/bash

DOTFILES=$PWD;

echo "Installing low level packages"
sudo pacman -S git vim sudo base-devel bash-completion eza htop strongswan --needed;


echo "Installing desktop environment packages"
sudo pacman -S pipewire pipewire-audio pipewire-pulse pavucontrol pamixer playerctl\
 alsa-firmware alsa-plugins alsa-utils brightnessctl starship\
 bluez bluez-utils blueman waybar dunst hyprland neofetch neovim swayidle\
 ttf-fira-code ttf-fira-mono ttf-firacode-nerd ttf-hack ttf-inconsolata ttf-inconsolata-nerd\
 tttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-liberation ttf-ubuntu-font-family ttf-ubuntu-mono-nerd ttf-ubuntu-nerd\
 sddm rofi nmp redshift grim slurp hyprlang sdbus-cpp xdg-desktop-portal-hyprland hypridle hyprlock --needed;

echo "Setting up sddm";
systemctl enable sddm;


echo "Installing yay";
cd ~;
$(git clone https://aur.archlinux.org/yay-git.git);
cd yay-git;
$(makepkg -si);
cd ..;
sudo rm -r yay-git;
cd $DOTFILES;

echo "Installing aur packages";
yay -Sy wpaperd breeze-hacked-cursor-theme sddm-swish swaylock-effects hyprsome-git hyprpicker kickoff wlogout --needed;

echo "Installing tpm";
$(git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm)

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

echo "Coping swaylock config";
cp -r .config/swaylock ~/.config/;

echo "Coping wallpapers";
cp -r .wallpapers ~/;

echo "Coping bash config";
cp .bashrc ~/;
cp -r .bash_completion ~/;
# }}}


echo "Installing applications"
sudo pacman -S vlc rhythmbox blender gimp musescore shotcut freecad\
  deja-dup libreoffice-fresh okular calibre\
  emacs alacritty root code texstudio\
  gnucash keepassxc geogebra firefox thunar qalculate-qt supertux --needed;

echo "Installing yay applications"
yay -S code-features duc update-notifier --needed;

echo "Coping emacs config";
cp -r .config/emacs ~/.config/;
