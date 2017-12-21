#!/bin/bash

#
# This is a script which auto-installs my GNU/Linux distribution of choice and
# an environment with hand-picked packages. Be warned, though, that running this
# script will erase all data on the selected partition.
#

# custom settings
_HOSTNAME=sumika
_KEYMAP=sv-latin1
_LANG=en_GB.UTF-8
_PARTITION=/dev/sda
_TIMEZONE=Europe/Stockholm
_USER=tora_chan

abort() {
  { printf "Error: $1. Aborting..." 1>&2; exit 1; }
}

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
printf "Welcome to Tora-chan's Automatic Installation Script! This will install a fully configured, ready-to-use system with %s on %s!\n" "$(_awesome)" "$(_archlinux)"
printf "\e[0;31mAttention! Beware that this will erase the entire %s partition & you'll lose all not previously backed up data! Proceed only if you're entirely sure!\e[0m\n\n" $_PARTITION

# check if run as root
[ $(id -u) -ne 0 ] && abort "You must run as root"

# get approval from user
dialogue "Do you wish to proceed?" || { printf "\nBye!\n"; exit; }

# show old partitions
lsblk

# create partitions
cat | fdisk $_PARTITION <<EOF
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
mkfs.ext2 ${_PARTITION}1
mkfs.ext4 ${_PARTITION}3
mkfs.ext4 ${_PARTITION}4
mkswap ${_PARTITION}2
swapon ${_PARTITION}2

# mount partitions
mount ${_PARTITION}3 /mnt
mkdir -p /mnt/{boot,home}
mount ${_PARTITION}1 /mnt/boot
mount ${_PARTITION}4 /mnt/home

# check result
lsblk

# find graphics card
_DRIVER="mesa lib32-mesa"
case "$(lspci | grep -e VGA -e 3D)" in
	*Intel*) _DRIVER="$_DRIVER xf86-video-intel" # xf86-video-nouveau xf86-video-ati xf86-video-amdgpu
esac

# install system packages
pacstrap /mnt base base-devel grub $_DRIVER

# write partition table
genfstab -U -p /mnt >> /mnt/etc/fstab

# enter into system
arch-chroot /mnt /bin/bash

# install boot loader
grub-install --recheck $_PARTITION
grub-mkconfig -o /boot/grub/grub.cfg

# setup pacman
sed -i -e 's/\#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
sed -i '/\[multilib\]/{n;s/.*/Include = \/etc\/pacman.d\/mirrorlist/}' /etc/pacman.conf
sed -i '/#VerbosePkgLists/a ILoveCandy' /etc/pacman.conf
pacman -Syy

# enable networking
cat > /etc/netctl/${_HOSTNAME}_ethernet <<EOF
Description='DHCP Ethernet Connection'
Connection=ethernet
Interface=$(ip link | awk -F': ' '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}')
IP=dhcp
EOF
netctl enable ${_HOSTNAME}_ethernet

# disable pc speaker
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
rmmod pcspkr

# set hostname
sed -i "/::1/a 127.0.0.1\t$_HOSTNAME.local\t\t$_HOSTNAME\n::1\t\t$_HOSTNAME.local\t\t$_HOSTNAME" /etc/hosts
hostnamectl set-hostname $_HOSTNAME

# set language
sed -i -e 's/\#$_LANG/$_LANG/g' /etc/locale.gen
[ ${_LANG##*en*} ] && sed -i -e 's/\#en_DK.UTF-8/en_DK.UTF-8/g' /etc/locale.gen
locale-gen
localectl set-locale LANG=$_LANG $([ ${_LANG##*en*} ] && echo "LC_TIME=en_DK.UTF-8")
localectl set-keymap $_KEYMAP

# set time
timedatectl set-timezone $_TIMEZONE
timedatectl set-ntp true
hwclock --systohc

# create user
useradd -G lp,vagrant,vboxusers,wheel -g users -m -s /bin/bash $_USER
passwd $_USER

# allow sudo usage for wheel
sed -i -e 's/ \#%wheel ALL=(ALL) ALL/ %wheel ALL=(ALL) ALL/g' /etc/sudoers

# set password for root
passwd

# install packages (see ./install_common.sh for more)
if [ dialogue "Install packages & dotfiles?" "Y" ]; then
  curl -LO https://raw.githubusercontent.com/joakimaling/system/master/install_common.sh && ./install_common.sh
fi

# clean up
exit
umount -R /mnt

# eject & reboot
dialogue "Eject CD-rom?" && eject
reboot
