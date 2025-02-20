{ config, pkgs, ... }:
{
  imports = [
    ./screen-locker.nix
    ./dunst.nix
    ./emanote-site.nix
    ./polybar
    ./udiskie.nix
  ];
}
