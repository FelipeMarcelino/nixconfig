{ config, lib, pkgs, ...}:
with lib; 
    let cfg = config.home.cli.fzf or { enable = false;} ; 

    in {

    options.home.cli.fzf = mkOption { 
     description = "Enable fuzzy finder";
     type = types.attrs;
     default = {enable = false;};
    };


    config = mkIf cfg.enable {
	  programs.fzf = {
	    enable = true;
	    defaultCommand = "fd";
	    defaultOptions = ["--border" "--height 60%" "--layout=reverse" "--info=inline" "--margin 1" "--padding 1"];
	    fileWidgetOptions = ["--preview 'bat -n --color=always {}'"];
	  };
	  home.packages = with pkgs; [ fd ];
    };

}
