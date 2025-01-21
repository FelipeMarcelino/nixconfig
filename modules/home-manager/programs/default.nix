{ config, pkgs, ... }:
{
  imports = [
    ./broot.nix
    ./rofi
    ./feh.nix
    ./taskwarrior
    ./zathura.nix
    ./zk.nix
  ];
}
