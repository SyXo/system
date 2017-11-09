#!/bin/bash

#
# This is a script which installs my hand-crafted environment
#

# custom settings
_HOSTNAME=sumika
_KEYMAP=sv-latin1
_LANG=en_GB.UTF-8
_TIMEZONE=Europe/Stockholm
_USER=tora_chan

dialogue() {
  while true; do
    read -p "$(printf "$1 [%s] " $([ "$2" == "Y" ] && echo "Yn" || echo "yN"))" answer  
    case $answer in
      [Yy]) return 0 ;;
      [Nn]) return 1 ;;
      "") [ "$2" == "Y" ] && return 0 || return 1 ;;
      *) echo "Y or N." ;;
    esac
  done
}

_archlinux() {
  echo -en "\e[0;36mArch Linux\e[0m"
}

_awesome() {
  echo -en "\e[1;30mawesome\e[0m"
}

# make preparations
loadkeys $_KEYMAP

# print welcome & warning messages
printf "Welcome to Tora-chan's Automatic Installer! This script will install a fully configured, ready-to-use system with %s on %s!\n" "$(_awesome)" "$(_archlinux)" 
printf "\e[0;31mAttention! Beware that this will erase the entire /dev/sda partition & you'll lose all not previously backed up data! Proceed only if you're entirely sure!\e[0m\n\n"
dialogue "Do you wish to proceed?" || { printf "\nBye!\n"; exit; }

lsblk

# create partitions
cat <<EOF | fdisk /dev/sda
o
n
p


+200M
n
p


+8G
n
p


+25G
n
p


w
EOF

# create file systems
mkfs.ext2 /dev/sda1
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mkswap /dev/sda2
swapon /dev/sda2

# mount partitions
mount /dev/sda3 /mnt
mkdir -p /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/home

# check result
lsblk
#dialogue "Is this OK?" "Y" || fdisk /dev/sda

# install system
pacstrap -i /mnt base base-devel grub

# write partition table
genfstab -U -p /mnt >> /mnt/etc/fstab

# enter system
arch-chroot /mnt /bin/bash

# install boot loader
grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# setup pacman
sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
sed -i 's/#Include = /etc/pacman.d/mirrorlist/Include = /etc/pacman/mirrorlist/g' /etc/pacman.conf
sed -e '/^#VerbosePkgLists/a ILoveCandy' /etc/pacman.conf > pacman.conf
pacman -Syy

# enable networking
cat > /etc/netctl/${_HOSTNAME}_ethernet <<EOF
Description='DHCP Ethernet Connection'
Connection=ethernet
Interface=eth0
IP=dhcp
EOF
netctl enable ${_HOSTNAME}_ethernet

# disable pc speaker
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
rmmod pcspkr

# set clock
hwclock --systohc

# set language & timezone
sed -i 's/#$_LANG/$_LANG/g' /etc/locale.gen
locale-gen
localectl set-locale LANG=$_LANG
localectl set-keymap $_KEYMAP
timedatectl set-timezone $_TIMEZONE
hostnamectl set-hostname $_HOSTNAME

# create user
useradd -m -g users -G lp,vagrant,wheel -s /bin/bash $_USER
passwd $_USER

# allow sudo usage for wheel
sed -i 's/ #%wheel ALL=(ALL) ALL/ %wheel ALL=(ALL) ALL/g' /etc/sudoers

# set password for root
passwd

# install packages (see ./install_packages.sh for more)
curl -O https://raw.githubusercontent.com/joakimaling/system/master/install_packages.sh && ./install_packages.sh

# clean up
exit
umount -R /mnt

# eject & reboot
dialogue "Eject CD-rom?" && eject
reboot
