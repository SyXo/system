# system
This is a compilation of scripts which aims to automate the installation process of [Arch Linux](https://www.archlinux.org/), my favourite packages and [dotfiles](https://github.com/joakimaling/dotfiles).

## Installation
When installing a new system; load the media which contains Arch Linux and type these commands when the prompt appears 
```
# curl -O https://raw.githubusercontent.com/joakimaling/system/master/install_system.sh
# ./install_system.sh
```
When only wanting to install the packages and dotfiles on an already installed system; type these commands
```
# curl -O https://raw.githubusercontent.com/joakimaling/system/master/install_packages.sh
# ./install_packages.sh
```

## Packages installed

### System packages
- [base]()
- [base-devel]()

### Custom packages

- [allegro]()
- [awesome]()
- [conky]()
- [cups]()
- [discord]()
- [dosbox]()
- [dropbox]()
- [feh]()
- [git]()
- [grub]()
- [gutenprint]() -- has drivers for Canon printers
- [htop]()
- [ibus]()
- [openssh]()
- [mplayer]()
- [neofetch]()
- [ranger]()
- [rxvt-unicode]()
- [steam]()
- [texlive-core]() -- for LaTeX
- [tmux]()
- [transmission-cli]()
- [ttf-hack]() -- primary terminal font
- [vim]()
- [virtualbox]()
- [wine-staging]() -- has better support for HearthStone
- [xcompmgr]() -- for true transperency
- [xorg-server]()
- [xorg-xinit]()

alsa-utils 1.1.4-1
bash 4.4.012-2
bind-tools 9.11.2-2
bzip2 1.0.6-6
clang 5.0.0-1
cmake 3.9.4-1
coreutils 8.28-1
cryptsetup 1.7.5-1
device-mapper 2.02.175-1
dhcpcd 6.11.5-1
diffutils 
e2fsprogs 1.43.7-1
evince 3.26.0+14+g2a499547-1
expac 8-1
filesystem 2017.03-2
firefox 56.0.2-1
gcc-libs 7.2.0-3
glibc 2.26-5
ibus-anthy 1.5.9-1
inetutils 1.9.4-5
iproute2 4.13.0-1
iputils 20161105.1f2bb12-2
jfsutils 1.1.15-4
jre8-openjdk 8.u144-1
jshon 20131105-1
less 487-1
lib32-gnutls 3.5.13-1
lib32-libldap 2.4.44-2
lib32-libpulse 11.1-1
lib32-mesa 17.2.4-1
lib32-openal 1.18.2-1
libreoffice-still 5.3.7-4
licenses 20171006-1
linux 4.13.11-1
logrotate 3.12.3-1
lvm2 2.02.175-1
man-db 2.7.6.1-2
man-pages 4.13-1
mdadm 4.0-1
mesa 17.2.4-1
mpc 0.28-1
nano 2.8.7-1
ncmpcpp 0.8.1-1
netctl 1.14-1
noto-fonts 20171025-1
noto-fonts-cjk 20170601-1
ntp 4.2.8.p10-2
packer 20160325-1
pciutils 3.5.5-1
pcmciautils 018-7
perl 5.26.1-1
procps-ng 3.3.12-1
psmisc 23.1-1
pulseaudio 11.1-1
pulseaudio-alsa 2-3
pygmentize 2.2.0-1
reiserfsprogs 3.6.25-1
s-nail 14.9.5-1
scrot 0.8.17-2
shadow 4.5-2
smartgit 17.1.1-1
sysfsutils 2.1.0-9
systemd-sysvcompat 235.38-1
tar 1.29-2
texlive-bin 2017.44590-7
texlive-core 2017.44918-1
thunderbird 52.4.0-1
ttf-dejavu 2.37-1
ufw 0.35-3
usbutils 008-1
vivaldi 1.12.955.48-1
wget 1.19.2-1
winetricks 20171018-1
xf86-video-intel 1:2.99.917+797+g4798e18b-1
xfsprogs 4.12.0-1

## More
- Test!
- Add Ubuntu (my servers run Ubuntu)
- Add options for laptops (battery, wireless)
- Detect graphics card and install correct drivers
