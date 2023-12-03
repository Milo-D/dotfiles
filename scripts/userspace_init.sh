#!/bin/sh

#
# personal userspace initialization script
#
# === overview === 
#
# This script initializes the userspace right after a minimal
# install of fedora. Here is a brief overview:
#
#   - installs required packages in order to setup the window manager
#   - installs and configures qtile window manager
#   - installs some additional, common software (editor, browser, ...)
#
# === requirements ===
#
# Before launching the script, do the following
#
#   1. boot into fedora everything image
#   2. atleast select minimal install
#   3. atleast select additional networkmanager submodules
#
# The steps above should result in a minimal install without a DE/WM. 
# We should then be able to launch this script from the user's home directory.
#

########## setup some common directories ##########

mkdir Desktop
mkdir Desktop/Repositories
mkdir Desktop/Scripts

mkdir Pictures
mkdir Documents
mkdir Downloads

########## install common packages ##########

sudo dnf -y install @base-x

sudo dnf -y install python3-pip
sudo dnf -y install python3-xcffib
sudo dnf -y install python3-cairocffi

sudo dnf -y install exa
sudo dnf -y install fd-find
sudo dnf -y install fzf
sudo dnf -y install hstr
sudo dnf -y install btop
sudo dnf -y install kitty
sudo dnf -y install qutebrowser
sudo dnf -y install zathura
sudo dnf -y install nitrogen
sudo dnf -y install zip
sudo dnf -y install tar
sudo dnf -y install bat
sudo dnf -y install neovim
sudo dnf -y install ctags
sudo dnf -y install screenfetch
sudo dnf -y install wget
sudo dnf -y install git
sudo dnf -y install ranger
sudo dnf -y install qemu
sudo dnf -y install tree
sudo dnf -y install ImageMagick
sudo dnf -y install NetworkManager-tui

sudo dnf -y install picom
sudo dnf -y install xclip
sudo dnf -y install xsel
sudo dnf -y install xrandr
sudo dnf -y install polybar
sudo dnf -y install rofi
sudo dnf -y install i3lock
sudo dnf -y install brightnessctl

sudo dnf -y install gcc
sudo dnf -y install gdb
sudo dnf -y install cmake
sudo dnf -y install valgrind
sudo dnf -y install ncurses-devel

sudo dnf -y install patchelf
sudo dnf -y install binwalk
sudo dnf -y install rizin

########## install common packages (pip) ##########

pip install qtile
pip install ropper

########## install pwndbg ##########

cd ~/Desktop/Repositories/
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh

cd ~

########## install vim plugin manager ########## 

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

########## install jetbrains mono font ##########

cd /tmp

wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
unzip JetBrainsMono-2.242.zip

sudo mkdir -p /usr/local/share/fonts/jetbrains
sudo cp fonts/ttf/*.ttf /usr/local/share/fonts/jetbrains

sudo chown -R root: /usr/local/share/fonts/jetbrains
sudo chmod 644 /usr/local/share/fonts/jetbrains/*
sudo restorecon -RF /usr/local/share/fonts/jetbrains
sudo fc-cache -v

cd ~

########## setup screenlocker ##########

git clone https://github.com/meskarune/i3lock-fancy.git

sudo install -Dm755 i3lock-fancy/i3lock-fancy -t /usr/bin/
sudo install -Dm644 i3lock-fancy/icons/* -t /usr/share/i3lock-fancy/icons/

rm -rf i3lock-fancy/

########## retrieve personal dotfiles, etc. ##########

cd Desktop/Scripts
git clone https://github.com/Milo-D/dotfiles.git

sudo cp dotfiles/misc/issue /etc/
sudo cp dotfiles/misc/40-libinput.conf /usr/share/X11/xorg.conf.d/

cp -r dotfiles/Wallpapers/ ~/Pictures/

cp dotfiles/config/.bash_profile ~/
cp dotfiles/config/.bashrc ~/
cp dotfiles/config/.xinitrc ~/
cp dotfiles/config/.rizinrc ~/

cp -r dotfiles/config/.bashrc.d/ ~/
cp -r dotfiles/config/qtile/ ~/.config/
cp -r dotfiles/config/kitty/ ~/.config/
cp -r dotfiles/config/nvim/ ~/.config/
cp -r dotfiles/config/polybar/ ~/.config/
cp -r dotfiles/config/qutebrowser/ ~/.config/
cp -r dotfiles/config/rofi/ ~/.config/
cp -r dotfiles/config/btop/ ~/.config/
cp -r dotfiles/config/picom/ ~/.config/
cp -r dotfiles/config/zathura/ ~/.config/
cp -r dotfiles/config/fzf/ ~/.config/

cd ~

########## miscellaneous ##########

sudo ln -s $(which rizin) /usr/bin/r2

####### Final Notes #######
#
# - run ":PlugUpdate" within neovim in order to load all plugins
#
#
