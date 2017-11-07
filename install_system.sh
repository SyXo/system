#!/bin/bash

#
# This is a script whihc installs my hand-crafted environment
#

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
#loadkeys sv-latin1

printf "Welcome! This script will install a system with %s on %s!\n" "$(_awesome)" "$(_archlinux)" 
printf "\e[0;31mBeware that you'll lose any not previously backed up data!\e[0m\n\n"
dialogue "Do you wish to proceed?" || { printf "\nBye!\n"; exit; }

read -p "Enter a username: " name


 





 #lsblk

# create partitions



# create file systems
#mkfs.ext4 /dev/sda1
#mkswap /dev/sda2
#swapon /dev/sda2

# mount partitions
#mount /dev/sda1 /mnt
#mkdir -p /mnt/{boot,home}
#mount /dev/sda1 /mnt/boot
#mount /dev/sda1 /mnt/home

# install system
#pacstrap -i /mnt base base-devel

#
#genfstab -U -p /mnt >> /mnt/etc/fstab

# 
#arch-chroot /mnt /bin/bash

#pacman -S grub
#grub-mkconfig -o /boot/grub/grub.cfg
#grub-install --recheck /dev/sda

# install packages
curl -O https://raw.githubusercontent.com/joakimaling/system/master/install_packages.sh && ./install_packages.sh

#exit
#umount -R /mnt
#reboot
