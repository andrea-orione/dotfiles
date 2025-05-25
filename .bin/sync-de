#!/bin/bash

# Hyprland
echo "Installing hyprland ecosistem"
sudo pacman -S\
    hyprland hyprsunset hypridle hyprlock wpaperd\
    --needed --noconfirm

# Display manager
echo ""
echo "Installing display manager"
sudo pacman -S sddm --needed --noconfirm

# Utils
echo ""
echo "Installing utils"
sudo pacman -S\
    waybar dunst udiskie rofi-wayland\
    grim slurp\
    cliphist wl-clipboard\
    --needed --noconfirm

# Audio
echo ""
echo "Installing audio packages"
sudo pacman -S\
    pipewire pipewire-audio pipewire-pulse\
    pavucontrol\
    pamixer\
    playerctl\
    alsa-firmware alsa-plugins alsa-utils\
    --needed --noconfirm

# Bluetooth and brightness
echo ""
echo "Installing bluetooth and brightness packages"
sudo pacman -S\
    brightnessctl\
    bluez bluez-utils blueman\
    --needed --noconfirm

# Network
echo ""
echo "Installing network packoges"
sudo pacman -S\
    strongswan vpnc\
    networkmanager\
    networkmanager-vpnc\
    networkmanager-l2tp\
    network-manager-applet\
    --needed --noconfirm

# Portals and stuff
echo ""
echo "Installing portals and stuff"
sudo pacman -S\
    xdg-desktop-portal-hyprland\
    xdg-desktop-portal-kde\
    xdg-desktop-portal-wlr\
    xdg-desktop-portal-gtk\
    xorg-server-xephyr\
    gnome-keyring\
    --needed --noconfirm

# Fonts
echo ""
echo "Installing fonts"
sudo pacman -S\
    ttf-ubuntu-font-family\
    ttf-ubuntu-mono-nerd\
    ttf-ubuntu-nerd\
    ttf-cascadia-code\
    --needed --noconfirm

# Printer
echo ""
echo "Installing printer manager"
sudo pacman -S system-config-printer --needed --noconfirm

# Config and stuff
echo ""
echo "Installing config packages"
sudo pacman -S stow xterm --needed --noconfirm


# AUR
echo ""
echo "Installing AUR packages"
paru -S\
    breeze-hacked-cursor-theme-git\
    sddm-swish\
    hyprsome-git\
    hyprpicker\
    wlogout\
    python-pylatexenc\
    --needed --noconfirm;
