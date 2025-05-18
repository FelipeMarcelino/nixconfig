{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.cli.aws or { enable = false; };
in
{
  options.home.cli.aws = mkOption {
    description = "Enable aws cli";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.aws = {
      enable = true;
    };
  };
}
