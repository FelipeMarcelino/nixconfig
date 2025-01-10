{config, pkgs, lib, ...}: let 
   cfg =  config.home.desktop.autorandr;
in
{
  options.home.desktop.autorandr = lib.mkOption {
    description = "Enable autorandr for X11";
    type = lib.types.attrs;
    default = {enable = false;};
  };
  


  config = lib.mkIf cfg.enable {
	programs.autorandr.enable = true;
	services.autorandr.enable = true;
  };

	
}
