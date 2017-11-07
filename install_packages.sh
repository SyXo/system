#!/bin/bash

# AUR installer
sudo pacman -S expac git jshon wget
wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
mv PKGBUILD\?h\=packer PKGBUILD
makepkg
sudo pacman -U packer-*.pkg.tar.xz

# install packages
packer -S --needed --noconfirm --noedit \
allegro awesome conky cups discord dosbox dropbox feh git gutenprint htop ibus \
openssh mplayer neofetch ranger rxvt-unicode steam texlive-core tmux \
transmission-cli ttf-hack vagrant vim virtualbox wine-staging xcompmgr xrog-server \
xorg-xinit

# fetch dotfiles
mkdir ~/Code && cd ~/Code
git clone https://github.com/joakimaling/dotfiles

#
cat <<BOX >> /etc/sudoers
Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/*
Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/* /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status --no-pager nfs-server.service
Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
%vagrant ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY
BOX

