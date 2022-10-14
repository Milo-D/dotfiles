#!/bin/bash

. /etc/X11/xinit/xinitrc-common

nitrogen --restore &
picom &
exec qtile start
