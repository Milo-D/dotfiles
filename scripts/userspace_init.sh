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
#   - installs some additional, common software (vim, firefox, ...)
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

sudo dnf install vim
sudo dnf install htop
sudo dnf install kitty
sudo dnf install firefox
sudo dnf install nitrogen
sudo dnf install zip
sudo dnf install bat
sudo dnf install micro
sudo dnf install picom
sudo dnf install screenfetch
sudo dnf install wget
sudo dnf install git
sudo dnf install xrandr
sudo dnf install ranger

########## install packages (software development) ##########

sudo dnf install gcc
sudo dnf install gdb

########## install packages (security research) ##########

sudo dnf install patchelf
sudo dnf install radare2

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

########## retrieve personal dotfiles ##########

mkdir Desktop/Scripts
cd Desktop/Scripts

git clone https://github.com/Milo-D/dotfiles.git

cp dotfiles/config/.bash_profile ~/
cp dotfiles/config/.bashrc ~/
cp dotfiles/config/.xinitrc ~/

cp dotfiles/config/kitty.conf ~/.config/kitty/
cp dotfiles/config/settings.json ~/.config/micro/

cd ~
