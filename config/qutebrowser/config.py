import os
import re
import sys

# qutebrowser binding
from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer

#
# == modes ==
#
# - normal
# - insert
# - command
# - caret
# - passthrough
#

#### initial steps ####

config = config;
c      = c;

config.load_autoconfig(False);

#### helpers ####

def bind(key, com, mode):

    config.bind(key, com, mode = mode);

def unbind(key, mode):

    config.unbind(key, mode = mode);

#### settings ####

#
# appearance
#
c.fonts.default_family = "Jetbrains Mono";

#
# hints
#
# c.hints.chars = 'abcdef';

#
# startpage
#
c.url.default_page = 'https://www.google.com/';
c.url.start_pages  = [ c.url.default_page ];

#
# misc
#
c.downloads.location.directory = '~/Downloads/';
c.auto_save.session            = True;
c.session.lazy_restore         = True;

#### keybindings ####

#
# prevent <ctrl-q> exit
#
unbind('<ctrl-q>', 'normal');

#
# browser grep
#
unbind('<n>',                         'normal');
unbind('<shift-n>',                   'normal');
bind(  '<ctrl-f>',  'set-cmd-text /', 'normal');
bind(  '<ctrl-n>',  'search-next',    'normal');
bind(  '<ctrl-p>',  'search-prev',    'normal');

#
# page navigation
#
unbind('<shift-h>',              'normal');
unbind('<shift-l>',              'normal');
bind(  '<alt-left>',  'back',    'normal');
bind(  '<alt-right>', 'forward', 'normal');

#
# page refresh
#
unbind('r',                  'normal');
bind(  '<ctrl-r>', 'reload', 'normal');

#### qutebrowser theme ####

#
# apply a theme from ~/.config/qutebrowser/themes/
#
config.source('themes/onedark.py');
