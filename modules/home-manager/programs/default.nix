{ config, pkgs, ... }:
{
  imports = [
    ./rofi
    ./feh.nix
    ./zathura.nix
  ];
}
