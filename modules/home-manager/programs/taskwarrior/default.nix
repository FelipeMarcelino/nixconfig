{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.taskwarrior or { enable = false; };
in
{
  options.home.programs.taskwarrior = mkOption {
    description = "Enable taskwarrior, a task manager. In also enables tui option (taskwarrior-tui)";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.taskwarrior = {
      enable = true;
      dataLocation = "$TASKWARRIOR_DIR";
      colorTheme = ./taskwarrior-catppuccin-theme.theme;
    };

    home.packages = with pkgs; [
      taskwarrior-tui
    ];

    systemd.user.tmpfiles.rules = [
      "d ${config.home.homeDirectory}/Taskwarrior/ 0755 felipemarcelino wheel - -"
    ];
  };

}
