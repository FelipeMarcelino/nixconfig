{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.home.services.screen-locker-x or { enable = false; };
in
{

  options.home.services.screen-locker-x = lib.mkOption {
    description = "Enable screen locker for X";
    type = lib.types.attrs;
    default = {
      enable = false;
    };
  };

  confg = lib.mkIf cfg.enable {
    services.screen-locker = {
      enable = true;
      inactiveInterval = 10;
      xautolock.enable = false;
      xss-lock = {
        extraOptions =
          let
            notify = pkgs.writeShellScript "notify" ''
              ${lib.getExe' pkgs.dunst "dunstify"} -t 30000 "30 seconds to lock"
            '';
          in
          [
            "--notifier ${notify}"
            "--transfer-sleep-lock"
            "--session $XDG_SESSION_ID"
          ];
        screensaverCycle = 600;
      };
    };

    home.packages = with pkgs; [
      betterlockscreen
    ];
  };

}
