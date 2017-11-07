#!/bin/bash

# AUR installer
sudo pacman -S expac git jshon wget
wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
mv PKGBUILD\?h\=packer PKGBUILD
makepkg
sudo pacman -U packer-*.pkg.tar.xz

# install packages
packer -S --needed --noconfirm --noedit \
allegro conky cups discord dosbox dropbox feh git gutenprint htop ibus openssh \
mplayer neofetch ranger rxvt-unicode steam texlive-core tmux transmission-cli \
ttf-hack vim virtualbox wine-staging

# fetch dotfiles
mkdir ~/Code && cd ~/Code
git clone https://github.com/joakimaling/dotfiles
