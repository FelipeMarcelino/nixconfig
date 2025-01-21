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
    description = "Enable starship for shell";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        custom = {
          taskin = {
            command = "task +in +PENDING count";
            symbol = " ";
            when = true;
            shell = "zsh";
          };
        };
      };
    };
  };
}
