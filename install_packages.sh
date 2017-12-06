#!/bin/bash

#
# This script installs all the packages & dotfiles I use daily.
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
awesome bc clang cmake conky cups discord dosbox dropbox feh firefox git \
gutenprint highlight htop ibus-anthy mediainfo mpc mplayer mupdf ncmpcpp \
neofetch openssh pulseaudio ranger rxvt-unicode scrot steam texlive-latexextra \
thunderbird tmux transmission-cli ttf-hack vim virtualbox wine-staging \
xcompmgr xrog-server xorg-xinit

# create folders
mkdir -p $_HOME/{Code,Documents/templates,Downloads/torrents,Music,Pictures,Videos,Virtual}

# install vim bundles
git clone https://github.com/editorconfig/editorconfig-vim.git $_HOME/.vim/bundle
git clone https://github.com/mattn/emmet-vim.git $_HOME/.vim/bundle

# change virtualbox folder
vboxmanage setproperty machinefolder $_HOME/Virtual

# add SSH keys
[ -f $_HOME/.ssh/id_rsa ] || ssh-keygen -C "$_USER@$_HOSTNAME" -b 4096 -t rsa

# enable cups & pulseaudio
systemctl enable org.cups.cupsd
systemctl enable pulseaudio

# edit downloads folder & start daemon
chgrp -R transmission $_HOME/Downloads
systemctl enable transmission

# enable images in ranger
ranger --copy-config=scope

# fetch dotfiles
git clone --recursive https://github.com/joakimaling/dotfiles $_HOME/Code

# link dotfiles
ln -sf $_HOME/Code/dotfiles/.bash_logout $_HOME
ln -sf $_HOME/Code/dotfiles/.bash_profile $_HOME
ln -sf $_HOME/Code/dotfiles/.bashrc $_HOME
ln -sf $_HOME/Code/dotfiles/bin/ $_HOME
ln -sf $_HOME/Code/dotfiles/.config/ $_HOME
ln -sf $_HOME/Code/dotfiles/.conkyrc $_HOME
ln -sf $_HOME/Code/dotfiles/.cvsignore $_HOME
ln -sf $_HOME/Code/dotfiles/.dircolors $_HOME
ln -sf $_HOME/Code/dotfiles/.dosbox $_HOME
ln -sf $_HOME/Code/dotfiles/.mplayer $_HOME
ln -sf $_HOME/Code/dotfiles/.tmux.conf $_HOME
ln -sf $_HOME/Code/dotfiles/.vimrc $_HOME
ln -sf $_HOME/Code/dotfiles/.vim/ $_HOME
ln -sf $_HOME/Code/dotfiles/.xinitrc $_HOME
ln -sf $_HOME/Code/dotfiles/.Xresources $_HOME

# link for root
ln -sf $_HOME/Code/dotfiles/.bash_logout /root
ln -sf $_HOME/Code/dotfiles/.bash_profile /root
ln -sf $_HOME/Code/dotfiles/.bashrc /root
ln -sf $_HOME/Code/dotfiles/bin/ /root

# configure git
git config --global core.excludesfile '~/.cvsignore'

# add development packages
curl -LO https://raw.githubusercontent.com/joakimaling/system/master/install_development.sh && ./install_development.sh
