{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.felipemarcelino = {
    isNormalUser = true;
    description = "Felipe Glicério Gomes Marcelino";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "bluetooth"
    ];

    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    #alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.git.enable = true;
  programs.gaming.enable = true;

  home-manager.users.felipemarcelino = import ../../../home-manager/felipemarcelino/${config.networking.hostName}.nix;
}
