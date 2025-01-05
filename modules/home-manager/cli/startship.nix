
{ config, lib, pkgs, ...}:
with lib; 
    let cfg = config.home.cli.startship or { enable = false;} ; 

    in {

    options.home.cli.starship = mkOption { 
     description = "Enable startship for shell";
     type = types.attrs;
     default = {enable = false;};
    };

    config = mkIf cfg.enable {
  	programs.starship.enable = true;
  };

}
