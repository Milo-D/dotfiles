# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from libqtile import hook, bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

#### constant definitions ####

env_user     = os.environ.get('USER');
env_hostname = os.environ.get('HOSTNAME');

mod          = "mod4";
terminal     = guess_terminal();

app_launcher = "rofi -show run";
screenlocker = "i3lock-fancy -p -f JetBrains-Mono-Bold -t " + env_user + "@" + env_hostname;

wmname       = "LG3D";
groups       = [Group(i) for i in "12345"];

#### wm hotkeys (general) ####

keys = [

    Key([mod           ], "Left",   lazy.layout.left(),          desc="Move focus to left"),
    Key([mod           ], "Right",  lazy.layout.right(),         desc="Move focus to right"),
    Key([mod           ], "Down",   lazy.layout.down(),          desc="Move focus down"),
    Key([mod           ], "Up",     lazy.layout.up(),            desc="Move focus up"),
    Key([mod           ], "space",  lazy.layout.next(),          desc="Move window focus to other window"),
    Key([mod, "control"], "Left",   lazy.layout.shuffle_left(),  desc="Move window to the left"),
    Key([mod, "control"], "Right",  lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "control"], "Down",   lazy.layout.shuffle_down(),  desc="Move window down"),
    Key([mod, "control"], "Up",     lazy.layout.shuffle_up(),    desc="Move window up"),
    Key([mod, "shift"  ], "Left",   lazy.layout.grow_left(),     desc="Grow window to the left"),
    Key([mod, "shift"  ], "Right",  lazy.layout.grow_right(),    desc="Grow window to the right"),
    Key([mod, "shift"  ], "Down",   lazy.layout.grow_down(),     desc="Grow window down"),
    Key([mod, "shift"  ], "Up",     lazy.layout.grow_up(),       desc="Grow window up"),
    Key([mod           ], "n",      lazy.layout.normalize(),     desc="Reset all window sizes"),
    Key([mod, "shift"  ], "Return", lazy.layout.toggle_split(),  desc="Toggle between split and unsplit sides of stack"),
    Key([mod           ], "Return", lazy.spawn(terminal),        desc="Launch terminal"),
    Key([mod           ], "Tab",    lazy.next_layout(),          desc="Toggle between layouts"),
    Key([mod           ], "w",      lazy.window.kill(),          desc="Kill focused window"),
    Key([mod, "control"], "r",      lazy.reload_config(),        desc="Reload the config"),
    Key([mod, "control"], "q",      lazy.shutdown(),             desc="Shutdown Qtile"),
    Key([mod           ], "r",      lazy.spawn(app_launcher),    desc="Start rofi as an applauncher"),
    Key([mod           ], "s",      lazy.spawn(screenlocker),    desc="Lock the screen")
];

#### wm hotkeys (workspaces) ####

for i in groups:

    keys.extend([

        Key([mod         ], i.name, lazy.group[i.name].toscreen(),                  desc="Switch to group {}".format(i.name)),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
    ]);


#### wm hotkeys (function keys) ####

keys.extend([

    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -d intel_backlight s 50-"), desc="Decrease screen brightness"),
    Key([], "XF86MonBrightnessUp",   lazy.spawn("brightnessctl -d intel_backlight s +50"), desc="Increase screen brightness")
]);

#### wm layouts ####

layouts = [

    layout.Columns(border_focus_stack = [ "#88c0d0", "#88c0d0" ],
                   border_normal      = [ "#3b4252", "#3b4252" ],
                   border_focus       = [ "#88c0d0", "#88c0d0" ],
                   border_width       = 4,
                   margin             = 8),
    
    layout.Max(),

    # more layouts:
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
];

widget_defaults    = dict(font="sans", fontsize=12, padding=3);
extension_defaults = widget_defaults.copy();

screens = [

    Screen()
];

# Drag floating layouts.
mouse = [

    Drag ([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag ([mod], "Button3", lazy.window.set_size_floating(),     start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
];

dgroups_key_binder = None;
dgroups_app_rules  = [];
follow_mouse_focus = True;
bring_front_click  = False;
cursor_warp        = False;

floating_layout = layout.Floating(float_rules=[

        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),       # gitk
        Match(wm_class="makebranch"),         # gitk
        Match(wm_class="maketag"),            # gitk
        Match(wm_class="ssh-askpass"),        # ssh-askpass
        Match(title="branchdialog"),          # gitk
        Match(title="pinentry")               # GPG key password entry
    ]
);

auto_fullscreen            = True;
focus_on_window_activation = "smart";
reconfigure_screens        = True;
auto_minimize              = True;
wl_input_rules             = None;

#### custom hooks ####

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh');
    subprocess.run([home]);
