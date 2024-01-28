#!/usr/bin/python3

import os;
import sys;
import subprocess

WD_OPS = 1;

def cwd_save():

    bash_session_pid = os.getppid();

    with open("/tmp/lcwd_" + str(bash_session_pid), 'w') as lcwd:
        lcwd.write(os.getcwd());

    lcwd.close();

def cwd_load(pid):

    try:
        with open("/tmp/lcwd_" + str(pid), "r") as lcwd:
            print(lcwd.readline());
    except:
        pass;

if len(sys.argv) < 2:
    exit();

#
# save cwd to a lcwd file 
#
if sys.argv[WD_OPS] == "cwd_save":
    cwd_save();

#
# load cwd from lcwd file for a given pid
#
if sys.argv[WD_OPS] == "cwd_load":

    if len(sys.argv) == 3:
        cwd_load(sys.argv[2]);

