{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.home.desktop.awesomewm;
in
{
  options.home.desktop.awesomewm = lib.mkOption {
    description = "AwesomeWM configuration";
    type = lib.types.submodule {
      options = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable AwesomeWM window manager";
        };
      };
    };
    default = { };
  };

  config = lib.mkIf cfg.enable {
    xsession.windowManager.awesome.enable = true;
    home.file.".config/awesome/rc.lua".source = ./rc.lua;
    home.file.".config/awesome/main/error-handling.lua".source = ./main/error-handling.lua;
    home.file.".config/awesome/main/user-variables.lua".source = ./main/user-variables.lua;
    home.file.".config/awesome/main/layouts.lua".source = ./main/layouts.lua;
    home.file.".config/awesome/main/tags.lua".source = ./main/tags.lua;
    home.file.".config/awesome/main/menu.lua".source = ./main/menu.lua;
    home.file.".config/awesome/main/rules.lua".source = ./main/rules.lua;
    home.file.".config/awesome/main/signals.lua".source = ./main/signals.lua;
  };
}
