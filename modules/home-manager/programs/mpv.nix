{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.home.programs.mpv or { enable = false; };
in
{

  options.home.programs.mpv = mkOption {
    description = "Enable mpv player";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.mpv.enable = true;
  };

}
