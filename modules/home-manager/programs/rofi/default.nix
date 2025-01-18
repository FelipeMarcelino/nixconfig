{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.rofi or { enable = false; };
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
      configPath = "./style.rasi";
    };
  };
}
