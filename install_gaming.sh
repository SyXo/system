#!/bin/bash

#
# This installs packages and sets the system up for gaming.
# Prerequisites: packer

# set constants if not passed through from ./install_packages.sh
[ -z $_USER ] && _USER=$(whoami)
_HOME=/home/$_USER

sudo -u $_USER packer -S --noconfirm --noedit \
dosbox steam wine-staging

# create folders
mkdir -p $_HOME/Games/{msdos,wine}

# link dosbox config
ln -sf $_HOME/Code/dotfiles/.dosbox $_HOME
