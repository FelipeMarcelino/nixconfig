{
  config,
  pkgs,
  lib,
  ...
}:
let
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
  cfg = config.home.desktop.i3 or { enable = false; };
in
{
  options.home.desktop.i3 = lib.mkOption {
    description = "Enable i3 wm with startx ";
    type = lib.types.attrs;
    default = {
      enable = false;
    };
  };

  config = lib.mkIf cfg.enable {
    xsession.enable = true;

    home.packages = with pkgs; [
      arandr
      flameshot
      candy-icons
    ];

    home.file.".local/share/xsessions/i3.desktop".text = ''
      [Desktop Entry]
      Name=i3
      Comment=Dynamic window manager
      Exec=${pkgs.i3-gaps}/bin/i3
      Type=XSession
    '';

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        fonts = {
          size = 18.0;
          names = [ "MonoLisa Nerd Font" ];
        };
        startup = [
          {
            command = "autorandr --load default; feh --bg-scale ${config.home.homeDirectory}/.wallpappers/horizontal.jpg ${config.home.homeDirectory}/.wallpappers/vertical.png";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --machine=felipemarcelino@.host --user start picom.service";
            always = true;
            notification = false;
          }
          {
            command = "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false";
            always = false;
            notification = false;
          }

          # {
          #   command = "autorandr --load default";
          #   always = true;
          #   notification = false;
          # }
        ];
        bars = [ ];
        modifier = mod;
        terminal = "ghostty";
        workspaceOutputAssign = [
          {
            output = [ "DP-0" ];
            workspace = "1";
          }
          {
            output = [ "DP-4" ];
            workspace = "2";
          }
          {
            output = [ "DP-0" ];
            workspace = "3";
          }
          {
            output = [ "DP-4" ];
            workspace = "4";
          }
          {
            output = [ "DP-0" ];
            workspace = "5";
          }
          {
            output = [ "DP-4" ];
            workspace = "6";
          }
          {
            output = [ "DP-0" ];
            workspace = "7";
          }
          {
            output = [ "DP-4" ];
            workspace = "8";
          } # Possible chatgpt?
          {
            output = [ "DP-0" ];
            workspace = "9";
          }
          {
            output = [ "DP-4" ];
            workspace = "10";
          }
        ];

        workspaceAutoBackAndForth = true;
        keybindings = {
          "${mod}+h" = "focus left";
          "${mod}+l" = "focus right";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+Return" = "exec --no-startup-id ghostty";
          "${mod}+d" = "exec rofi -show drun -icon-theme candy-icons";
          "${mod}+q" = "kill";
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+l" = "move right";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+y" = "exec --no-startup-id ghostty -e yazi";
          "${mod}+t" = "exec --no-startup-id thunar";
          "${mod}+c" = "split h";
          "${mod}+v" = "split v";
          "${mod}+p" = "exec --no-startup-id \"flameshot screen\"";
          "${mod}+Shift+p" = "exec --no-startup-id \"flameshot gui\"";
          "${mod}+s" = "layout toggle";
          "${mod}+e" = "layout toggle split";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+Shift+e" =
            "exec i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";
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
        };
        floating.border = 4;
        window = {
          titlebar = false;
          hideEdgeBorders = "none";
          border = 4;
        };
        colors = {
          background = base07;

          focused = {
            background = base0D;
            border = base05;
            childBorder = base0C;
            indicator = base0D;
            text = base00;
          };

          focusedInactive = {
            background = base01;
            border = base01;
            childBorder = base01;
            indicator = base03;
            text = base05;
          };

          unfocused = {
            background = base00;
            border = base01;
            childBorder = base01;
            indicator = base01;
            text = base05;
          };

          urgent = {
            background = base08;
            border = base08;
            childBorder = base08;
            indicator = base08;
            text = base00;
          };

          placeholder = {
            background = base00;
            border = base00;
            childBorder = base00;
            indicator = base00;
            text = base05;
          };
        };
        gaps = {
          smartGaps = false;
          smartBorders = "off";
          inner = 4;
          outer = 4;
        };
        assigns = {
          "1" = [ { class = "ghostty"; } ];
          "2" = [
            { class = "discord"; }
            { class = "Element"; }
          ];
          "3" = [ { class = "firefox"; } ];
          "4" = [ { class = "Spotify"; } ];
        };
      };
      extraConfig = " for_window [class=.*] border pixel 4";
    };
  };
}
