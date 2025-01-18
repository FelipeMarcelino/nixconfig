{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.cli.starship or { enable = false; };
in
{
  options.home.cli.starship = mkOption {
    description = "Enable ghostty terminal emulater";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ ghostty ];
  };
}
