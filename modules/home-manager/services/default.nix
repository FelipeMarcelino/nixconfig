{ config, pkgs, ... }:
{
  imports = [
    ./dunst.nix
    ./polybar
  ];
}
