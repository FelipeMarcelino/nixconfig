{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.broot or { enable = false; };
in
{
  options.home.programs.broot = mkOption {
    description = "Enable broot directory tree view";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.broot = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        modal = true;
      };
    };
  };
}
