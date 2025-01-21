{ config, pkgs, ... }:
{
  imports = [
    ./rofi
    ./feh.nix
    ./taskwarrior
    ./zathura.nix
    ./zk.nix
  ];
}
