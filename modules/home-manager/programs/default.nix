{ config, pkgs, ... }:
{
  imports = [
    ./broot.nix
    ./rofi
    ./feh.nix
    ./mpv.nix
    ./taskwarrior
    ./yazi.nix
    ./yt-dlp.nix
    ./zathura.nix
    ./zk.nix
  ];
}
