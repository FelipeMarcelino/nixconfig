{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.felipemarcelino = {
    isNormalUser = true;
    description = "Felipe Glicério Gomes Marcelino";
    extraGroups = ["networkmanager" "wheel" "audio" "video"];

    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  home-manager.users.felipemarcelino = import ../../../home-manager/felipemarcelino/${config.networking.hostName}.nix;
}
