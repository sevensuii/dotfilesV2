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

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os
import subprocess

mod = "mod4"
# terminal = "kitty"
terminal = "alacritty"

@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([home])

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    ####################
    # Switch between windows  #
    ####################
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left with arrows"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right with arrows"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down with arrows"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up with arrows"),
    #######################################################
    # Move windows between left/right columns or move up/down in current stack.  #
    # Moving out of range in Columns layout will create new column.                              #
    #######################################################
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left with arrows"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right with arrows"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down with arrows"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up with arrows"),
    ###################################################
    # Grow windows. If current window is on the edge of screen and direction  #
    # will be to screen edge - window would shrink.                                                    #
    ###################################################
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left with arrows"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right with arrows"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down with arrows"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up with arrows"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toogle floating"),
    ###########################################
    # Toggle between split and unsplit sides of stack.                          #
    # Split = all windows displayed                                                            #
    # Unsplit = 1 window displayed, like Max layout, but still with  #
    # multiple stack panes                                                                           #
    ###########################################
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack", ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    #####################
    # Switch focus of monitors      #
    #####################
    Key([mod], "period", lazy.prev_screen()),
    Key([mod], "comma", lazy.next_screen()),
    ############
    # Screenshots     #
    ############
    Key([], "Print", lazy.spawn("flameshot gui"), desc="Lauch Flameshot GUI"),
    Key([mod], 'Print', lazy.spawn('flameshot screen'), desc='Takes screenshot of current screen'),
    Key([mod, 'shift'], 'Print', lazy.spawn('flameshot full'), desc='Takes screenshot of the entire workspace'),
    ###################
    # Rofi launcher  and apps   #
    ###################
    Key(["mod1"], "space", lazy.spawn("rofi -show drun"), desc="Open Rofi launcher"),
    Key(["mod1"], "Tab", lazy.spawn("rofi -show"), desc="Show active windows"),
    Key([mod], 'f', lazy.spawn("alacritty -T Ranger -e ranger"), desc="Launch ranger terminal file manager"),
    # Key([mod], "space", lazy.spawn("~/git_repos/dotfiles/scripts/kb_layout_change"), desc="Changes the keyboard layout"),
    #############
    # Audio options    #
    #############
    Key([], "XF86AudioLowerVolume", lazy.spawn("/bin/sh -c '~/git_repos/dotfilesV2/scripts/default_device_volume.sh output s -5'"), desc="Increase System Volume"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("/bin/sh -c '~/git_repos/dotfilesV2/scripts/default_device_volume.sh output s +5'"), desc="Deccrease System Volume"),
    Key([], "XF86AudioMute", lazy.spawn("/bin/sh -c '~/git_repos/dotfilesV2/scripts/default_device_volume.sh output m'"), desc="Mute System Volume"),
    ##################
    # Temporal media keys     #
    ##################
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"),desc="Toggle Play-Pause Music"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"),desc="Play Previous Music Track"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Play Next Music Track"),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop"), desc="Stop the Music"),
    ####################
    # All keys need some work    #
    ####################
    # Key([], "XF86MonBrightnessDown", lazy.spawn("bash -e ~/.config/qtile/Scripts/bright_control down"),     desc="Decrease Screen Brightness"),
    # Key([], "XF86MonBrightnessUp", lazy.spawn("bash -e ~/.config/qtile/Scripts/bright_control up"), desc="Increase Screen Brightness"),
    # Key([], "XF86Launch3", lazy.spawn("bash -e ~/.config/qtile/Scripts/rog_kb_menu"), desc="Keyboard RBG controll"),
    # Key(["mod1"], "w", lazy.spawn("bash -e ~/.config/qtile/Scripts/wifi_menu"), desc="Launch Wi-fi menu script"),
]

# groups = [Group(i) for i in "123456789"]
groups = [
    Group("1", label ='󰖟'),
    Group("2", label ='', layout = "zoomy"),
    Group("3", label =''),
    Group("4", label =''),
    Group("5", label ='󰙯'),
    Group("6", label ='󰙯'),
    Group("7", label ='󰎅'),
    Group("8", label = ''),
    #Group("9", label = fa.icons["firefox"]),
]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(border_focus="#EB47E5", border_width=4, margin = 5),
    layout.Max(margin = 5),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    layout.Zoomy(margin = 5, columnwidth = 300),
]

# widget_defaults = dict(
#     font="sans",
#     fontsize=12,
#     padding=3,
# )
# extension_defaults = widget_defaults.copy()

# Gap because I'm using Polybar instead of the Qtile bar
screens = [
    Screen(top=bar.Gap(35),),
    Screen(top=bar.Gap(35),),
    Screen(top=bar.Gap(35),),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="TCalendar"),  # calcurse as a small widget
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "Qtile"
