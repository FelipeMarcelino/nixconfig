{
  pkgs,
  config,
  lib,
  ...
}:
with lib;

let
  cfg = config.home.customServices.udiskie or { enable = false; };
in
{

  options.home.customServices.udiskie = mkOption {
    description = "Enable service udiskie automount disk";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
      settings = {
        program_options = {
          file_manager = "${pkgs.mimeo}/bin/mimeo";
        };
      };
      tray = "always";
    };
  };
}
