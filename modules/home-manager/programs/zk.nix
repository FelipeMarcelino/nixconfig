{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.zettelkasten or { enable = false; };
in
{
  options.home.programs.zettelkasten = mkOption {
    description = "Enable zettelkasten (zk). Notes are located in $HOME/Zettelkasten. Change the author on module file.";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zk = {
      enable = true;

    };
  };
}
