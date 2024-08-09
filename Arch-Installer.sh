#!/bin/bash

DOTFILES=$PWD;

echo "Installing low level packages"
sudo pacman -S git vim nano sudo base-devel bash-completion eza lazygit htop strongswan stow\
  networkmanager networkmanager-l2tp tmux zsh --needed;

echo "Installing desktop environment packages"
sudo pacman -S pipewire pipewire-audio pipewire-pulse pavucontrol pamixer playerctl xterm tree-sitter-cli\
 alsa-firmware alsa-plugins alsa-utils brightnessctl starship cmatrix network-manager-applet\
 bluez bluez-utils blueman waybar dunst hyprland neofetch fastfetch neovim udiskie wpaperd luarocks\
 ttf-fira-code ttf-fira-mono ttf-firacode-nerd ttf-hack ttf-inconsolata ttf-inconsolata-nerd\
 tttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-liberation ttf-ubuntu-font-family ttf-ubuntu-mono-nerd ttf-ubuntu-nerd\
 sddm rofi-wayland nmp redshift grim slurp hyprlang sdbus-cpp xdg-desktop-portal-hyprland\
 xdg-desktop-portal-kde xdg-desktop-portal-wlr xorg-server-xephyr hypridle hyprlock --needed;

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
yay -Sy cava breeze-hacked-cursor-theme sddm-swish hyprsome-git hyprpicker kickoff wlogout python-pylatexenc --needed;

echo "Installing tpm";
$(git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm)

echo "Coping config files";
stow .

echo "Installing programming libraries"
sudo pacman -S cern-vdt ipython jupyter-notebook python-numba python-pandas --needed

echo "Installing applications"
sudo pacman -S vlc rhythmbox blender gimp musescore shotcut freecad system-config-printer\
  deja-dup libreoffice-fresh okular calibre arduino filelight nomacs prusa-slicer\
  emacs alacritty kitty konsole root code texstudio blanket kdeconnect thunderbird\
  gnucash keepassxc geogebra firefox thunar qalculate-qt supertux android-file-transfer --needed;

echo "Installing yay applications"
yay -S code-features duc update-notifier pipes.sh --needed;

echo "Setting zsh as the default shell"
chsh -s /bin/zsh $USERNAME

