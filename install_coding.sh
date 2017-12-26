#!/bin/bash

#
# Installs my development environment I use for work as well as hobby.
# Prerequisites: packer
#

# custom settings
_EMAIL=joakim.aling@gmail.com
_NAME=joakimaling

# set constants if not passed through from ./install_packages.sh
[ -z $_USER ] && _USER=$(whoami)
_HOME=/home/$_USER

# install papkages
sudo -u $_USER packer -S --noconfirm --noedit \
allegro fpc gimp jdk8-openjdk mariadb nfs-utils npm php ruby vagrant virtualbox

# add administrative privileges
usermod -a vagrant,vboxusers $_USER

# setup git
git config -f $_HOME/.gitconfig color.ui auto
git config -f $_HOME/.gitconfig user.email $_EMAIL
git config -f $_HOME/.gitconfig user.name $_NAME

# configure the database
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation

# enable drivers for php
sed -i -e 's/ \;extension=pdo_mysql/extension=pdo_mysql/g' /etc/php/php.ini

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --filename=composer --install-dir=$_HOME/bin
php -r "unlink('composer-setup.php');"

# install jekyll
gem install bundler jekyll

# create virtual foder & change virtualbox folder
mkdir -p $_HOME/Virtual
vboxmanage setproperty machinefolder $_HOME/Virtual

# allow password-less use of nfs
cat >> /etc/sudoers <<BOX
Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/*
Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/* /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status --no-pager nfs-server.service
Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
%vagrant ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_STA    RT, VAGRANT_NFSD_APPLY
BOX
