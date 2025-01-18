{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.cli.ghostty or { enable = false; };
in
{
  options.home.cli.ghostty = mkOption {
    description = "Enable ghostty terminal emulator";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
  };
}
