# system
This is a compilation of scripts which aims to automate the installation process of [Arch Linux](https://www.archlinux.org/), my favourite packages and [dotfiles](https://github.com/joakimaling/dotfiles) onto a new system.

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
The packages I use are split up according to the installation process. The system packages are installed when Arch Linux is being installed to set up a functional system that will boot.

### System packages
- [base](https://www.archlinux.org/groups/x86_64/base/)
- [base-devel](https://www.archlinux.org/groups/x86_64/base-devel/)
- [grub](https://www.archlinux.org/packages/core/x86_64/grub/)

### Custom packages

- [allegro](https://www.archlinux.org/packages/community/x86_64/allegro/)
- [awesome](https://www.archlinux.org/packages/community/x86_64/awesome/)
- [conky](https://www.archlinux.org/packages/extra/x86_64/conky/)
- [cups](https://www.archlinux.org/packages/extra/x86_64/cups/)
- [discord](https://aur.archlinux.org/packages/discord/)
- [dosbox](https://www.archlinux.org/packages/community/x86_64/dosbox/)
- [dropbox](https://aur.archlinux.org/packages/dropbox/)
- [feh](https://www.archlinux.org/packages/extra/x86_64/feh/)
- [git](https://www.archlinux.org/packages/extra/x86_64/git/)
- [gutenprint](https://www.archlinux.org/packages/extra/x86_64/gutenprint/) -- has drivers for Canon printers
- [highlight](https://www.archlinux.org/packages/community/x86_64/highlight/)
- [htop](https://www.archlinux.org/packages/extra/x86_64/htop/)
- [ibus](https://www.archlinux.org/packages/extra/x86_64/ibus/)
- [mediainfo](https://www.archlinux.org/packages/community/x86_64/mediainfo/)
- [mplayer](https://www.archlinux.org/packages/extra/x86_64/mplayer/)
- [neofetch](https://aur.archlinux.org/packages/neofetch/)
- [openssh](https://www.archlinux.org/packages/core/x86_64/openssh/)
- [packer](https://aur.archlinux.org/cgit/aur.git/snapshot/packer.tar.gz)
- [ranger](https://www.archlinux.org/packages/community/any/ranger/)
- [rxvt-unicode](https://www.archlinux.org/packages/community/x86_64/rxvt-unicode/)
- [steam](https://www.archlinux.org/packages/multilib/x86_64/steam/)
- [texlive-latexextra](https://www.archlinux.org/packages/extra/any/texlive-latexextra/) -- for LaTeX
- [tmux](https://www.archlinux.org/packages/community/x86_64/tmux/)
- [transmission-cli](https://www.archlinux.org/packages/extra/x86_64/transmission-cli/)
- [ttf-hack](https://www.archlinux.org/packages/extra/any/ttf-hack/) -- primary terminal font
- [vagrant](https://www.archlinux.org/packages/community/x86_64/vagrant/)
- [vim](https://www.archlinux.org/packages/extra/x86_64/vim/)
- [virtualbox](https://www.archlinux.org/packages/community/x86_64/virtualbox/)
- [wine-staging](https://www.archlinux.org/packages/multilib/x86_64/wine-staging/) -- has better support for HearthStone
- [xcompmgr](https://www.archlinux.org/packages/extra/x86_64/xcompmgr/) -- for true transparency
- [xorg-server](https://www.archlinux.org/packages/extra/x86_64/xorg-server/)
- [xorg-xinit](https://www.archlinux.org/packages/extra/x86_64/xorg-xinit/)

alsa-utils 1.1.4-1
bind-tools 9.11.2-2
clang 5.0.0-1
cmake 3.9.4-1
evince 3.26.0+14+g2a499547-1
firefox 56.0.2-1
ibus-anthy 1.5.9-1
jre8-openjdk 8.u144-1
lib32-gnutls 3.5.13-1
lib32-libldap 2.4.44-2
lib32-libpulse 11.1-1
lib32-mesa 17.2.4-1
lib32-openal 1.18.2-1
mesa 17.2.4-1
mpc 0.28-1
ncmpcpp 0.8.1-1
noto-fonts 20171025-1
noto-fonts-cjk 20170601-1
pulseaudio 11.1-1
pulseaudio-alsa 2-3
pygmentize 2.2.0-1
scrot 0.8.17-2
smartgit 17.1.1-1
thunderbird 52.4.0-1
ttf-dejavu 2.37-1
ufw 0.35-3
winetricks 20171018-1
xf86-video-intel 1:2.99.917+797+g4798e18b-1

## Disclaimer
This code is distributed as is. I hold no responsibility to any possible damage to your system.

## More
- Test!
- Add Ubuntu (my servers run Ubuntu)
- Add options for laptops (battery, wireless)
- Detect graphics card and install correct drivers
