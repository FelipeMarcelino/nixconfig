

{ config, lib, pkgs, ...}:
with lib; 
    let cfg = config.home.cli.bat or { enable = false;} ; 

    in {

    options.home.cli.bat = mkOption { 
     description = "Enable bat that is a substitute of cat";
     type = types.attrs;
     default = {enable = false;};
    };


    config = mkIf cfg.enable {
	  programs.bat = {
	    enable = true;
	    extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batpipe prettybat];
	  };
    };

}
