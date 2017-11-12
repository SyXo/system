#!/bin/bash

#
# This script installs all the packages & dotfiles I use daily.
#

# set constants if not passed through from ./install_system.sh
[ -z $_HOSTNAME ] && _HOSTNAME=$(hostname)
[ -z $_USER ] && _USER=$(whoami)

# AUR installer
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/packer.tar.gz
tar -xz packer.tar.gz && cd packer
makepkg -is --noconfirm
cd .. && rm -r packer*

# install packages
packer -S --needed --noconfirm --noedit \
allegro awesome bc conky cups discord dosbox dropbox feh git gutenprint htop \
ibus openssh mplayer neofetch ranger rxvt-unicode steam texlive-core tmux \
transmission-cli ttf-hack vagrant vim virtualbox wine-staging xcompmgr \
xrog-server xorg-xinit

# create pictures folder
mkdir /home/$_USER/Pictures

# create downloads folder & start daemon
mkdir -p /home/$_USER/Downloads/torrents
chgrp -R transmission /home/$_USER/Downloads
systemctl enable transmission

# enable cups
systemctl enable org.cups.cupsd

# fetch dotfiles
mkdir /home/$_USER/Code && cd /home/$_USER/Code
git clone https://github.com/joakimaling/dotfiles

# link dotfiles
cd /home/$_USER
ln -sf /home/$_USER/Code/.bash_logout
ln -sf /home/$_USER/Code/.bash_profile
ln -sf /home/$_USER/Code/.bashrc
ln -sf /home/$_USER/Code/bin/
ln -sf /home/$_USER/Code/.config/
ln -sf /home/$_USER/Code/.conkyrc
ln -sf /home/$_USER/Code/.dircolors
ln -sf /home/$_USER/Code/.dosbox
ln -sf /home/$_USER/Code/.fonts.conf
ln -sf /home/$_USER/Code/.mplayer
ln -sf /home/$_USER/Code/.tmux.conf
ln -sf /home/$_USER/Code/.vimrc
ln -sf /home/$_USER/Code/.xinitrc
ln -sf /home/$_USER/Code/.Xresources

# add SSH keys
[ -f /home/$_USER/.ssh/id_rsa ] || ssh-keygen -b 4096 -t rsa -C "$_USER@$_HOSTNAME"

# allow password-less use of nfs
cat <<BOX >> /etc/sudoers
Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/*
Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/* /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status --no-pager nfs-server.service
Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
%vagrant ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY
BOX
