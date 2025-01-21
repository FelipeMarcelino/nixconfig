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
    description = "Enable taskwarrior, a task manager";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.taskwarrior = {
      enable = true;
      dataLocation = "$TASKWARRIOR_DIR";
    };
  };

  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/Taskwarrior/ 0755 felipemarcelino wheel - -"
  ];
}
