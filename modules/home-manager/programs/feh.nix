{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.feh or { enable = false; };
in
{
  options.home.programs.feh = mkOption {
    description = "Enable feh wallpapper tool";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.feh.enable = true;
  };
}
