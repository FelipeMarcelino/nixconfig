{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.services.emanote-site or { enable = false; };
in
{
  options.home.services.emanote-site = mkOption {
    description = "Enable Emanote website automatic service execution. Available to localhost:8080";
    type = types.attrs;
    default = {
      enable = false;
      path = "";
    };
    example = {
      enable = true;
      path = "path/to/your/content";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services."emanote-site" = {
      Unit = {
        Description = "Emanote site service";
      };
      Service = {
        ExecStart = ''
          ${pkgs.emanote}/bin/emanote --layers ${cfg.path} run --port 8080
        '';
        Restart = "always";
        RestartSec = "5s";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
