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
  options.home.home.ghostty = mkOption {
    description = "Enable starship for shell";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghostty
    ];
  };
}
