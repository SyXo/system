#!/bin/bash

#
# This script installs all the packages & dotfiles I use daily.
#

# set constants if not passed through from ./install_system.sh
[ -z $_HOSTNAME ] && _HOSTNAME=$(hostname)
[ -z $_USER ] && _USER=$(whoami)
_HOME=/home/$_USER

# AUR installer
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/packer.tar.gz
tar -xz packer.tar.gz && cd packer
makepkg -is --noconfirm
cd .. && rm -r packer*

# install packages
sudo -u $_USER packer -S --needed --noconfirm --noedit \
allegro awesome bc conky cups discord dosbox dropbox feh git gutenprint \
highlight htop ibus mediainfo mplayer neofetch openssh ranger rxvt-unicode \
steam texlive-latexextra tmux transmission-cli ttf-hack vagrant vim virtualbox \
wine-staging xcompmgr xrog-server xorg-xinit

# create folders
mkdir -p $_HOME/{Code,Documents,Downloads/torrents,Music,Pictures,Videos,Virtual}
mkdir -p $_HOME/.vim/{autoload,bundle}

# install pathogen
curl -LSso $_HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install vim bundles
git clone https://github.com/editorconfig/editorconfig-vim.git $_HOME/.vim/bundle
git clone https://github.com/mattn/emmet-vim.git $_HOME/.vim/bundle

# change virtualbox folder
vboxmanage setproperty machinefolder $_HOME/Virtual

# add SSH keys
[ -f $_HOME/.ssh/id_rsa ] || ssh-keygen -b 4096 -t rsa -C "$_USER@$_HOSTNAME"

# enable cups
systemctl enable org.cups.cupsd

# edit downloads folder & start daemon
chgrp -R transmission $_HOME/Downloads
systemctl enable transmission

# fetch dotfiles
git clone https://github.com/joakimaling/dotfiles $_HOME/Code

# link dotfiles
ln -sf $_HOME/Code/.bash_logout
ln -sf $_HOME/Code/.bash_profile
ln -sf $_HOME/Code/.bashrc
ln -sf $_HOME/Code/bin/
ln -sf $_HOME/Code/.config/
ln -sf $_HOME/Code/.conkyrc
ln -sf $_HOME/Code/.cvsignore
ln -sf $_HOME/Code/.dircolors
ln -sf $_HOME/Code/.dosbox
ln -sf $_HOME/Code/.fonts.conf
ln -sf $_HOME/Code/.mplayer
ln -sf $_HOME/Code/.tmux.conf
ln -sf $_HOME/Code/.vimrc
ln -sf $_HOME/Code/.xinitrc
ln -sf $_HOME/Code/.Xresources

# allow password-less use of nfs
cat >> /etc/sudoers <<BOX
Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/*
Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/* /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status --no-pager nfs-server.service
Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
%vagrant ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY
BOX
