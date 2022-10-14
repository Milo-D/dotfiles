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
# TODO: upload dotfiles and retrieve + use them in this script.
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

########## TODO: setup minimal X ##########

# wget .xinitrc
# mv .xinitrc ~/

touch .xinitrc # TODO: export dotfile
printf '#!/bin/bash\n\n. /etc/X11/xinit/xinitrc-common\nexec qtile start\n' > .xinitrc

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

########### TODO: configure kitty ###########

# wget kitty.conf
# mv kitty.conf ~/.config/kitty/

########### TODO: configure micro ###########

# wget settings.json
# mv settings.json ~/.config/micro/

########### TODO: autostart X ##########

# TODO: export dotfile
# autostart X by appending following line to the user's .bash_profile
# [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1
