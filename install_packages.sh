#!/bin/bash

#
# This script installs all the common packages & dotfiles I use daily.
#

# set constants if not passed through from ./install_system.sh
[ -z $_HOSTNAME ] && _HOSTNAME=$(hostname)
[ -z $_USER ] && _USER=$(whoami)
_HOME=/home/$_USER

# AUR installer
curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/packer.tar.gz
tar -xz packer.tar.gz && cd packer
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
git clone https://github.com/editorconfig/editorconfig-vim.git $_HOME/.vim/bundle
git clone https://github.com/mattn/emmet-vim.git $_HOME/.vim/bundle

# enable cups & pulseaudio
systemctl enable org.cups.cupsd
systemctl enable pulseaudio

# edit downloads folder & start daemon
chgrp -R transmission $_HOME/Downloads
systemctl enable transmission

# enable images in ranger
ranger --copy-config=scope

# fetch & link dotfiles
git clone --recursive https://github.com/joakimaling/dotfiles.git $_HOME/Code
$_HOME/Code/dotfiles/install.sh

# configure git
git config --global core.excludesfile '~/.cvsignore'

# setup for coding
curl -LO https://raw.githubusercontent.com/joakimaling/system/master/install_coding.sh && ./install_coding.sh

# setup for gaming
curl -LO https://raw.githubusercontent.com/joakimaling/system/master/install_gaming.sh && ./install_gaming.sh
