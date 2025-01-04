{ lib, inputs, outputs, }
{
    
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.felipemarcelino = {
    isNormalUser = true;
    description = "Felipe Glicério Gomes Marcelino";
    extraGroups = [ "networkmanager" "wheel" "audio" "video"];
    packages = with pkgs; [
    #  thunderbird
    ];

    packages = [inputs.home-manager.packages.${pkgs.system}.nix;
  };

  home-manager.users.felipemarcelino = import ../../../home/felipemarcelino/${config.networking.hostName}.nix; 
  skldjkflskljfkl

}
