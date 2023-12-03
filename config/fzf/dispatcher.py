#!/usr/bin/python3

import os;
import sys;
import subprocess

def dispatch_to(handler, detach):

    cmd = handler + " " + sys.argv[1];

    if detach == False:
        os.system(cmd);
        return;

    subprocess.Popen(cmd, stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL,
                          stderr=subprocess.DEVNULL, shell=True);

if sys.argv[1:] == []:
    exit();

_, extension = os.path.splitext(sys.argv[1]);

match extension:
    case '.pdf':
        dispatch_to("zathura", True);
    case _:
        dispatch_to("nvim", False);

