{ config, pkgs, lib, inputs, outputs, ... }: 
{
    
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.felipemarcelino = {
    isNormalUser = true;
    description = "Felipe Glicério Gomes Marcelino";
    extraGroups = [ "networkmanager" "wheel" "audio" "video"];

    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };

  home-manager.users.felipemarcelino = import ../../../home-manager/felipemarcelino/${config.networking.hostName}.nix; 

}
