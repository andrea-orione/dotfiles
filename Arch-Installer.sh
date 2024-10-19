#!/bin/bash

DOTFILES=$PWD;

echo "Installing low level packages"
sudo pacman -S git vim nano sudo base-devel bash-completion eza lazygit htop strongswan stow\
  networkmanager networkmanager-l2tp tmux zsh --needed;

echo "Installing desktop environment packages"
sudo pacman -S pipewire pipewire-audio pipewire-pulse pavucontrol pamixer playerctl xterm tree-sitter-cli\
 alsa-firmware alsa-plugins alsa-utils brightnessctl starship cmatrix network-manager-applet wl-clipboard\
 bluez bluez-utils blueman waybar dunst hyprland neofetch fastfetch neovim udiskie wpaperd luarocks cliphist\
 ttf-fira-code ttf-fira-mono ttf-firacode-nerd ttf-hack\
 tttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-liberation ttf-ubuntu-font-family ttf-ubuntu-mono-nerd ttf-ubuntu-nerd\
 sddm rofi-wayland nmp gammastep grim slurp hyprlang sdbus-cpp xdg-desktop-portal-hyprland bat git-delta\
 vpnc networkmanager-vpnc\
 xdg-desktop-portal-kde xdg-desktop-portal-wlr xdg-desktop-portal-gtk xorg-server-xephyr hypridle hyprlock zoxide gnome-keyring --needed;


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

echo "Installing programming libraries"
sudo pacman -S cern-vdt ipython jupyter-notebook python-numba python-pandas python-jupytext --needed

echo "Installing applications"
sudo pacman -S vlc rhythmbox blender gimp musescore shotcut freecad system-config-printer\
  deja-dup libreoffice-fresh okular calibre arduino filelight nomacs prusa-slicer\
  emacs alacritty konsole root code texstudio blanket kdeconnect thunderbird\
  gnucash keepassxc geogebra firefox thunar gvfs thunar-archive-plugin thunar-media-tags-plugin tumbler qalculate-qt supertux android-file-transfer --needed;

echo "Installing yay applications"
yay -S code-features duc update-notifier pipes.sh --needed;

echo "Setting zsh as the default shell"
chsh -s /bin/zsh $USERNAME

