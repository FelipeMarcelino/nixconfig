{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.terminal.ghostty or { enable = false; };
in
{
  options.home.terminal.ghostty = mkOption {
    description = "Enable ghostty terminal emulator";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghostty
    ];

    home.file.".config/ghostty/config".text = ''
      font-family = MonoLisa Nerd Font
      font-size = 20
      theme = catppuccin-macchiato 
      cursor-click-to-move = true
      mouse-shift-capture = true
      unfocused-split-opacity = 0.7
      fullscreen = true
      link-url = true
      window-inherit-working-directory = true
      window-inherit-font-size = true
      window-decoration = false
      custom-shader-animation = true
      bold-is-bright = true
      clipboard-trim-trailing-spaces = true
      copy-on-select = true
      window-save-state = always
      mouse-hide-while-typing = true
      gtk-single-instance = true
      gtk-titlebar = false
      keybind = ctrl+w>l=goto_split:right
      keybind = ctrl+w>h=goto_split:left
      keybind = ctrl+w>j=goto_split:bottom
      keybind = ctrl+w>k=goto_split:top
      keybind = ctrl+w>f=toggle_split_zoom
      keybind = ctrl+w>d=close_surface
      keybind = ctrl+alt+l=resize_split:right,10
      keybind = ctrl+alt+h=resize_split:left,10
      keybind = ctrl+alt+j=resize_split:down,10
      keybind = ctrl+alt+k=resize_split:up,10
      keybind = ctrl+w>space=toggle_tab_overview
      keybind = ctrl+w>1=goto_tab:1
      keybind = ctrl+w>2=goto_tab:2
      keybind = ctrl+w>3=goto_tab:3
      keybind = ctrl+w>4=goto_tab:4
      keybind = ctrl+w>5=goto_tab:5
      keybind = ctrl+w>6=goto_tab:6
      keybind = ctrl+w>7=goto_tab:7
      keybind = ctrl+w>8=goto_tab:8
      keybind = ctrl+w>9=goto_tab:9

    '';
  };
}
