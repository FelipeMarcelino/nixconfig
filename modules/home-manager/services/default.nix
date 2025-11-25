{ config, pkgs, ... }:
{
  imports = [
    ./screen-locker.nix
    ./dunst.nix
    ./polybar
    ./picom.nix
    ./udiskie.nix
  ];
}
