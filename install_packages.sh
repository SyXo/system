#!/bin/bash

#
# This script installs all the packages & dotfiles I use daily.
#

_HOSTNAME=sumika
_USER=tora_chan

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

#
cat <<BOX >> /etc/sudoers
Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/*
Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/* /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status --no-pager nfs-server.service
Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
%vagrant ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY
BOX

