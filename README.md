# system
This is a compilation of scripts which aims to automate the installation process of [Arch Linux](https://www.archlinux.org/), my favourite packages and [dotfiles](https://github.com/joakimaling/dotfiles) onto a new system. It also optionally installs packages for development and gaming.

## Installation
When installing a new system; load the Arch Linux installation media and type these commands when a prompt appears
```
curl -LO https://raw.githubusercontent.com/joakimaling/system/master/install_system.sh
./install_system.sh
```
When only wanting to install the packages and dotfiles on an existing system; type these commands
```
curl -LO https://raw.githubusercontent.com/joakimaling/system/master/install_common.sh
./install_common.sh
```
The scripts will optionally set up environments for development and gaming. But if you'd wish to only install these separately; type these commands respectively (requires [packer](https://github.com/keenerd/packer))
```
curl -LO https://raw.githubusercontent.com/joakimaling/system/master/install_coding.sh
./install_coding.sh

curl -LO https://raw.githubusercontent.com/joakimaling/system/master/install_gaming.sh
./install_gaming.sh
```

## Packages installed
The packages I use are split into several groups; system, common, coding and gaming packages. The latter three can be setup independently of the system packages.

### System packages
- [base](https://www.archlinux.org/groups/x86_64/base/)
- [base-devel](https://www.archlinux.org/groups/x86_64/base-devel/)
- [grub](https://www.archlinux.org/packages/core/x86_64/grub/)
- [lib32-mesa](https://www.archlinux.org/packages/multilib/x86_64/lib32-mesa/)
- [mesa](https://www.archlinux.org/packages/extra/x86_64/mesa/)
- And one of:
  - [xf86-video-intel](https://www.archlinux.org/packages/extra/x86_64/xf86-video-intel/)

### Common packages
- [awesome](https://www.archlinux.org/packages/community/x86_64/awesome/)
- [conky](https://www.archlinux.org/packages/extra/x86_64/conky/)
- [discord](https://aur.archlinux.org/packages/discord/)
- [dropbox](https://aur.archlinux.org/packages/dropbox/)
- [feh](https://www.archlinux.org/packages/extra/x86_64/feh/)
- [firefox](https://www.archlinux.org/packages/extra/x86_64/firefox/)
- [git](https://www.archlinux.org/packages/extra/x86_64/git/)
- [gutenprint](https://www.archlinux.org/packages/extra/x86_64/gutenprint/) -- has drivers for Canon printers
- [ghostscript](https://www.archlinux.org/packages/extra/x86_64/ghostscript/)
- [highlight](https://www.archlinux.org/packages/community/x86_64/highlight/)
- [htop](https://www.archlinux.org/packages/extra/x86_64/htop/)
- [ibus-anthy](https://www.archlinux.org/packages/community/x86_64/ibus-anthy/) -- for Japanese input
- [mediainfo](https://www.archlinux.org/packages/community/x86_64/mediainfo/)
- [mpc](https://www.archlinux.org/packages/extra/x86_64/mpc/)
- [mplayer](https://www.archlinux.org/packages/extra/x86_64/mplayer/)
- [mupdf](https://www.archlinux.org/packages/community/x86_64/mupdf/)
- [ncmpcpp](https://www.archlinux.org/packages/community/x86_64/ncmpcpp/)
- [neofetch](https://aur.archlinux.org/packages/neofetch/)
- [openssh](https://www.archlinux.org/packages/core/x86_64/openssh/)
- [packer](https://aur.archlinux.org/cgit/aur.git/snapshot/packer.tar.gz)
- [pulseaudio](https://www.archlinux.org/packages/extra/x86_64/pulseaudio/)
- [ranger](https://www.archlinux.org/packages/community/any/ranger/)
- [rxvt-unicode](https://www.archlinux.org/packages/community/x86_64/rxvt-unicode/)
- [sc-im](https://aur.archlinux.org/packages/sc-im/)
- [scrot](http://freecode.com/projects/scrot)
- [texlive-latexextra](https://www.archlinux.org/packages/extra/any/texlive-latexextra/) -- for LaTeX
- [thunderbird](https://www.archlinux.org/packages/extra/x86_64/thunderbird/)
- [tmux](https://www.archlinux.org/packages/community/x86_64/tmux/)
- [transmission-cli](https://www.archlinux.org/packages/extra/x86_64/transmission-cli/)
- [ttf-hack](https://www.archlinux.org/packages/extra/any/ttf-hack/) -- primary terminal font
- [vim](https://www.archlinux.org/packages/extra/x86_64/vim/)
- [xcompmgr](https://www.archlinux.org/packages/extra/x86_64/xcompmgr/) -- for true transparency
- [xorg-server](https://www.archlinux.org/packages/extra/x86_64/xorg-server/)
- [xorg-xinit](https://www.archlinux.org/packages/extra/x86_64/xorg-xinit/)

### Coding packages
- [allegro](https://www.archlinux.org/packages/community/x86_64/allegro/)
- [fpc](https://www.archlinux.org/packages/community/x86_64/fpc/)
- [jdk8-openjdk](https://www.archlinux.org/packages/extra/x86_64/jdk8-openjdk/)
- [mariadb](https://www.archlinux.org/packages/extra/x86_64/mariadb/)
- [php](https://www.archlinux.org/packages/extra/x86_64/php/)
- [vagrant](https://www.archlinux.org/packages/community/x86_64/vagrant/)
- [virtualbox](https://www.archlinux.org/packages/community/x86_64/virtualbox/)

### Gaming packages
- [dosbox](https://www.archlinux.org/packages/community/x86_64/dosbox/)
- [steam](https://www.archlinux.org/packages/multilib/x86_64/steam/)
- [wine-staging](https://www.archlinux.org/packages/multilib/x86_64/wine-staging/)

## Disclaimer
This code is distributed as is. I hold no responsibility to any possible damage to your system.

## More
- Test!
- Add Ubuntu (my servers run Ubuntu)
- Add options for laptops (battery, wireless)
