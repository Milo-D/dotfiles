#!/bin/bash

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
mkdir Pictures
mkdir Documents
mkdir Downloads

########## install qtile dependencies ##########

sudo dnf install @base-x

sudo dnf install python3-pip
sudo dnf install python3-xcffib
sudo dnf install python3-cairocffi

pip install qtile

########## install packages (core utilities) ##########

sudo dnf install htop
sudo dnf install kitty
sudo dnf install qutebrowser
sudo dnf install nitrogen
sudo dnf install zip
sudo dnf install tar
sudo dnf install bat
sudo dnf install micro
sudo dnf install screenfetch
sudo dnf install wget
sudo dnf install git
sudo dnf install git-email
sudo dnf install ranger
sudo dnf install qemu
sudo dnf install tree
sudo dnf install ImageMagick

########## install packages (window-manager stuff) ##########

sudo dnf install picom
sudo dnf install xclip
sudo dnf install xsel
sudo dnf install xrandr
sudo dnf install polybar
sudo dnf install rofi
sudo dnf install i3lock

########## install packages (software development) ##########

sudo dnf install gcc
sudo dnf install gdb
sudo dnf install cmake
sudo dnf install ncurses-devel

########## install packages (security research) ##########

sudo dnf install patchelf
sudo dnf install radare2
sudo dnf install binwalk

pip install ropper

mkdir Desktop/Repositories
cd Desktop/Repositories

git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh

cd ~

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

mkdir Desktop/Scripts
cd Desktop/Scripts

git clone https://github.com/Milo-D/dotfiles.git

cp -r dotfiles/Wallpapers/ ~/Pictures/

cp dotfiles/config/.bash_profile ~/
cp dotfiles/config/.bashrc ~/
cp dotfiles/config/.xinitrc ~/

cp -r dotfiles/config/qtile/ ~/.config/
cp -r dotfiles/config/kitty/ ~/.config/
cp -r dotfiles/config/micro/ ~/.config/
cp -r dotfiles/config/polybar/ ~/.config/
cp -r dotfiles/config/qutebrowser/ ~/.config/
cp -r dotfiles/config/rofi/ ~/.config/

cd ~
