{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.dunst or { enable = false; };
in
{
  options.home.programs.dunst = mkOption {
    description = "Enable notifier dusntrc";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.dunst.enable = true;

    programs.dunst.settings = {
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
        format = "<b>%s</b>\n%b";
        vertical-align = "center";
        icon_position = "left";
        word_wrap = "yes";
        ignore_newline = "no";
        show_indicators = "yes";
        sort = true;
        stack_duplicates = true;
        startup_notification = false;
        hide_duplicate_count = true;
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

    programs.dunst.iconTheme = {
      name = "BeautyLine";
      package = pkgs.beauty-line-icon-theme;
      size = "16x16";
    };
  };
}
