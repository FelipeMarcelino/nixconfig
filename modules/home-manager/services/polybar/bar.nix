{ config, ... }:

let
  bar = ''
    [bar/main]
    monitor = ''${env:MONITOR:DP-0}
    width = 100%
    height = 48
    radius = 6.0
    fixed-center = true

    background = ''${color.bg}
    foreground = ''${color.fg}

    padding-left = 0
    padding-right = 0

    module-margin-left = 1
    module-margin-right = 2

    cursor-click = pointer
    cursor-scroll = ns-resize

    overline-size = 2
    overline-color = ''${color.ac}

    border-bottom-size = 0
    border-color = ''${color.ac}

    ; Text Fonts
    font-0 = Iosevka Nerd Font:style=Medium:size=16;3
    ; Icons Fonts
    font-1 = icomoon\\-feather:style=Medium:size=18;3
    ; Powerline Glyphs
    font-2 = Iosevka Nerd Font:style=Medium:size=40;3
    ; Larger font size for bar fill icons
    font-3 = Iosevka Nerd Font:style=Medium:size=28;3
    ; Smaller font size for shorter spaces
    font-4 = Iosevka Nerd Font:style=Medium:size=7;3
    ; Keyboard layout icons
    font-5 = FlagsWorldColor:size=16:antialias=false;3
    ;font-5 = "MaterialIcons:size=40;0"
    ;font-6 = Font Awesome 5 Free:style=Solid:pixelsize=20;3
    ;font-5 = Unifont:size=64:antialias=false;1
  '';

  top = ''
    [bar/top]
    inherit = bar/main

    modules-left = right-end-top nixos i3 left-end-bottom right-end-top left-end-top
    modules-right = left-end-top clickable-keyboard clickable-github temperature clickable-date battery
    modules-center = tray
    enable-ipc = true
  '';

  bottom = ''
    [bar/bottom]
    inherit = bar/main
    bottom = true

    modules-left = right-end-bottom mpris left-end-top cpu memory filesystem
    modules-right = left-end-bottom wired-network wireless-network pulseaudio left-end-bottom powermenu
    enable-ipc = true
  '';

  tray = ''

    [module/tray]
    type = internal/tray
    tray-position = center
    tray-padding = 3
    background = ''${color.bg}
    override-redirect = true
  '';
in
bar + top + bottom + tray
