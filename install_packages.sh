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
highlight htop ibus ibus-anthy mediainfo mpc mplayer ncmpcpp neofetch openssh \
ranger rxvt-unicode scrot steam texlive-latexextra tmux transmission-cli \
ttf-hack vagrant vim virtualbox wine-staging xcompmgr xrog-server xorg-xinit

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
git clone --recursive https://github.com/joakimaling/dotfiles $_HOME/Code

# link dotfiles
ln -sf $_HOME/Code/.bash_logout $_HOME
ln -sf $_HOME/Code/.bash_profile $_HOME
ln -sf $_HOME/Code/.bashrc $_HOME
ln -sf $_HOME/Code/bin/ $_HOME
ln -sf $_HOME/Code/.config/ $_HOME
ln -sf $_HOME/Code/.conkyrc $_HOME
ln -sf $_HOME/Code/.cvsignore $_HOME
ln -sf $_HOME/Code/.dircolors $_HOME
ln -sf $_HOME/Code/.dosbox $_HOME
ln -sf $_HOME/Code/.fonts.conf $_HOME
ln -sf $_HOME/Code/.mplayer $_HOME
ln -sf $_HOME/Code/.tmux.conf $_HOME
ln -sf $_HOME/Code/.vimrc $_HOME
ln -sf $_HOME/Code/.xinitrc $_HOME
ln -sf $_HOME/Code/.Xresources $_HOME

# link for root
ln -sf $_HOME/Code/.bash_logout /root
ln -sf $_HOME/Code/.bash_profile /root
ln -sf $_HOME/Code/.bashrc /root
ln -sf $_HOME/Code/bin/ /root

# configure git
git config --global core.excludesfile '~/.cvsignore'

# allow password-less use of nfs
cat >> /etc/sudoers <<BOX
Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/*
Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/* /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status --no-pager nfs-server.service
Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
%vagrant ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY
BOX
