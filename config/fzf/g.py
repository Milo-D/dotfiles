#!/usr/bin/python3

#
# g [additional flags] search_request
#

import os;
import sys;
import uuid;

n_args = len(sys.argv[1:]);

if n_args == 0 or n_args > 2:
    exit();

if n_args == 1:
    request = sys.argv[1];
    flags   = ""; 

if n_args == 2:
    request = sys.argv[2];
    flags   = sys.argv[1];

search_cmd = f'''echo $(echo $(grep -nr{flags} {request} --color=always 2> /dev/null |
                 fzf --ansi --layout=reverse --border=bottom) | awk -F ":" '{{print $1 " " $2}}')''';

#
# A hacky way to read from stdout without using
# subprocesses. Had issues with python subprocesses
# but was too lazy to fix them the proper way.
#
choice_file = "/tmp/g." + str(uuid.uuid4());
os.system(search_cmd + " > " + choice_file);

with open(choice_file, "r") as file:
    choice = file.readline();

if (len(choice_split := choice.strip().split(" ")) == 2): 
    os.system("nvim " + choice_split[0] + " +" + choice_split[1]);

os.system("rm " + choice_file);

