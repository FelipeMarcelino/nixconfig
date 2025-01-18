{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.rofi or { enable = false; };
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  options.home.programs.rofi = mkOption {
    description = "Enable rofi launch program";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      font = "PragmataProMono Nerd Font";
      theme = builtins.readFile ./theme.rasi;
    };
  };
}
