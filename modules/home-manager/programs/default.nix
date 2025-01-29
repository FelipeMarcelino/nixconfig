{ config, pkgs, ... }:
{
  imports = [
    ./broot.nix
    ./rofi
    ./feh.nix
    ./mpv.nix
    ./taskwarrior
    ./zathura.nix
    ./zk.nix
  ];
}
