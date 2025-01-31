{ config, pkgs, ... }:
{
  imports = [
    ./broot.nix
    ./rofi
    ./feh.nix
    ./mpv.nix
    ./taskwarrior
    ./yazi.nix
    ./zathura.nix
    ./zk.nix
  ];
}
