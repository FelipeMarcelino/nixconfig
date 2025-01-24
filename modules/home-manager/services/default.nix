{ config, pkgs, ... }:
{
  imports = [
    ./dunst.nix
    ./emanote-site.nix
    ./polybar
    ./udiskie.nix
  ];
}
