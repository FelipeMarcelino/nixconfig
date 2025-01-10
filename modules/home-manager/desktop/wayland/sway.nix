{
  config,
  pkgs,
  lib,
  ...
}: let
  mod = "Mod1";
  base00 = "#282c34";
  base01 = "#353b45";
  base02 = "#3e4451";
  base03 = "#545862";
  base04 = "#565c64";
  base05 = "#abb2bf";
  base06 = "#b6bdca";
  base07 = "#c8ccd4";
  base08 = "#e06c75";
  base09 = "#d19a66";
  base0A = "#e5c07b";
  base0B = "#98c379";
  base0C = "#56b6c2";
  base0D = "#61afef";
  base0E = "#c678dd";
  base0F = "#be5046";
  cfg = config.home.desktop.swayi3 or {enable = false;};
in {
  options.home.desktop.swayi3 = lib.mkOption {
    description = "Enable i3 wm with sway  and wayland ";
    type = lib.types.attrs;
    default = {enable = false;};
  };

  config = lib.mkIf cfg.enable {
    services.gnome-keyring.enable = true;

    home.packages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      grim # screenshot functionality
      slurp # screenshot functionality
      mako # notification system developed by swaywm mai
    ];

    programs.wofi.enable = true;
    programs.waybar.enable = true;

    wayland.windowManager.sway = {
      wrapperFeatures.gtk = true;

      enable = true;
      config = {
        fonts = {
          size = 18.0;
          names = ["MonoLisa Nerd Font"];
        };
        bars = [
          {
            fonts.size = 15.0;
            command = "waybar";
          }
        ];
        modifier = mod;
        terminal = "kgx";
        workspaceOutputAssign = [
          {
            output = ["DP-0"];
            workspace = "1";
          }
          {
            output = ["DP-4"];
            workspace = "2";
          }
          {
            output = ["DP-0"];
            workspace = "3";
          }
          {
            output = ["DP-4"];
            workspace = "4";
          }
          {
            output = ["DP-0"];
            workspace = "5";
          }
          {
            output = ["DP-4"];
            workspace = "6";
          }
          {
            output = ["DP-0"];
            workspace = "7";
          }
          {
            output = ["DP-4"];
            workspace = "8";
          } # Possible chatgpt?
          {
            output = ["DP-0"];
            workspace = "9";
          }
          {
            output = ["DP-4"];
            workspace = "10";
          }
        ];

        workspaceAutoBackAndForth = false;
        keybindings = {
          "${mod}+h" = "focus left";
          "${mod}+l" = "focus right";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+Return" = "exec --no-startup-id kgx";
          "${mod}+d" = "exec rofi -show drun -icon-theme candy-icons";
          "${mod}+q" = "kill";
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+l" = "move right";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+c" = "split h";
          "${mod}+v" = "split v";
          "${mod}+p" = "exec --no-startup-id \"flameshot screen\"";
          "${mod}+Shift+p" = "exec --no-startup-id \"flameshot gui\"";
          "${mod}+s" = "layout toggle";
          "${mod}+e" = "layout toggle split";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
          "${mod}+Shift+x" = "exec betterlockscreen -l dim";
          "${mod}+minus" = "move scratchpad";
          "${mod}+Shift+minus" = "scratchpad show";
          "${mod}+b" = "exec --no-startup-id rofi-bluetooth";
        };
      };
    };
  };
}
