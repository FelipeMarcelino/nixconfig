{ config, lib, pkgs, ...}:
with lib; 
    let cfg = config.home.cli.eza or { enable = false;} ; 

    in {

    options.home.cli.eza = mkOption { 
     description = "Enable eza substitute of ls";
     type = types.attrs;
     default = {enable = false;};
    };

    config = mkIf cfg.enable {
	    programs.eza = {
	    enable = true;
	    #enableAliases = true;
	    enableZshIntegration = true;
	    git = true;
	    icons = "auto";
	    extraOptions = [
	      "--group-directories-first"
	      "--smart-group"
	      "--header"
	      "--git-repos"
	      "--total-size"
	      "--git"
	      "--header"
	      "--hyperlink"
	      "--tree"
	    ];
	  };
  };

}
