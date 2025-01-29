{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.services.dunst or { enable = false; };
in
{
  options.home.services.dunst = mkOption {
    description = "Enable notifier dusnt with catppuccin theme";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    services.dunst.enable = true;

    services.dunst.settings = {
      global = {
        frame_color = "#8aadf4";
        separator_color = "frame";
        highlight = "#8aadf4";
        monitor = 0;
        padding = 16;
        shrink = "yes";
        horizontal_padding = 16;
        frame_width = 3;
        font = "PragmataProMono Nerd Font";
        line_height = 4;
        idle_threshold = 120;
        markup = "full";
        alignment = "left";
        format = "<b>%s</b>\\n%b";
        icon_position = "left";
        word_wrap = "yes";
        ignore_newline = "no";
        show_indicators = "yes";
        sort = true;
        stack_duplicates = true;
        hide_duplicate_count = true;
        enable_recursive_icon_lookup = true;
      };
      experimental = {
        enable_recursive_icon_lookup = true;
      };
      urgency_low = {
        background = "#24273a";
        foreground = "#cad3f5";
      };
      urgency_normal = {
        background = "#24273a";
        foreground = "#cad4f5";
      };
      urgency_critical = {
        background = "#24273a";
        foreground = "#cad4f5";
        frame_color = "#f5a97f";
      };
    };

    services.dunst.iconTheme = {
      name = "BeautyLine";
      package = pkgs.beauty-line-icon-theme;
      size = "16x16";
    };
  };
}
