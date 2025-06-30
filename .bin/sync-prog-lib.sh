#!/bin/bash

echo "Installing programming libraries"
sudo pacman -S\
    cern-vdt root\
    ipython\
    jupyter-notebook\
    python-numba\
    python-pandas\
    bear\
    --needed --noconfirm

paru -S\
    python-jupytext\
    --needed --noconfirm
