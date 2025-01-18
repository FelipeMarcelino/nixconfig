{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.terminal.ghostty or { enable = false; };
in
{
  options.home.terminal.ghostty = mkOption {
    description = "Enable ghostty terminal emulator";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ghostty ];
  };
}
