{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.home.desktop.awesomewm or { enable = false; };
in
{

  options.home.desktop.awesomewm = {

    description = "Enable awesome wm with startx ";
    type = lib.types.attrs;
    default = {
      enable = false;
    };
  };

  config = lib.mkIf cfg.enable {

    xsession.windowManager.awesome.enable = true;
    home.file.".config/awesome/rc.lua".source = ./rc.lua;
  };

}
