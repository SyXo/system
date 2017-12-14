#!/bin/bash

#
# This script installs all the common packages & dotfiles I use daily. Also, it
# sets up the environment just the way I like it.
#

# set constants if not passed through from ./install_system.sh
[ -z $_HOSTNAME ] && _HOSTNAME=$(hostname)
[ -z $_USER ] && _USER=$(whoami)
_HOME=/home/$_USER

# git repository addresses
_GITHUB_RAW=https://raw.githubusercontent.com/joakimaling/system/master
_GITHUB=https://github.com

# AUR installer
curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/packer.tar.gz
tar -f packer.tar.gz -x -z && cd packer
makepkg -is --noconfirm
cd .. && rm -r packer*

# add key for discord
gpg --recv-key 0FC3042E345AD05D

# install packages
sudo -u $_USER packer -S --noconfirm --noedit \
awesome bc clang cmake conky discord dropbox feh firefox git ghostscript \
gutenprint highlight htop ibus-anthy mediainfo mpc mplayer mupdf ncmpcpp \
neofetch openssh pulseaudio ranger rxvt-unicode scrot texlive-latexextra \
thunderbird tmux transmission-cli ttf-hack vim xcompmgr xrog-server xorg-xinit

# add SSH keys
[ -f $_HOME/.ssh/id_rsa ] || ssh-keygen -C "$_USER@$_HOSTNAME" -b 4096 -t rsa

# create folders
mkdir -p $_HOME/{Code,Documents/templates,Downloads/torrents,Music,Pictures,Videos}

# install vim bundles
git clone $_GITHUB/editorconfig/editorconfig-vim.git $_HOME/.vim/bundle
git clone $_GITHUB/mattn/emmet-vim.git $_HOME/.vim/bundle

# enable cups & pulseaudio
systemctl enable org.cups.cupsd
systemctl enable pulseaudio

# edit downloads folder & start daemon
chgrp -R transmission $_HOME/Downloads
systemctl enable transmission

# enable images in ranger
ranger --copy-config=scope

# fetch & link dotfiles
git clone --recursive $_GITHUB/joakimaling/dotfiles.git $_HOME/Code
$_HOME/Code/dotfiles/install.sh

# configure git
git config --global core.excludesfile '~/.cvsignore'

# setup for coding
curl -LO $_GITHUB_RAW/install_coding.sh && ./install_coding.sh

# setup for gaming
curl -LO $_GITHUB_RAW/install_gaming.sh && ./install_gaming.sh
