{ config, pkgs, ... }:
{
  imports = [
    ./dunst.nix
    ./polybar
    ./udiskie.nix
  ];
}
