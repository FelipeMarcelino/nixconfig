{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.cli.azure or { enable = false; };
in
{
  options.home.cli.azure = mkOption {
    description = "Enable azure cli";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      azure-cli
    ];
  };
}
