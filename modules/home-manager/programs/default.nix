{ config, pkgs, ... }:
{
  imports = [
    ./rofi
    ./feh.nix
    ./taskwarrior.nix
    ./zathura.nix
    ./zk.nix
  ];
}
