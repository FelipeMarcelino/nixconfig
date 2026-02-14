{ config, pkgs, ... }:
{
  imports = [
    ./broot.nix
    ./claude_code.nix
    ./rofi
    ./feh.nix
    ./firefox.nix
    ./mpv
    ./taskwarrior
    ./yazi.nix
    ./yt-dlp.nix
    ./zathura.nix
    ./zk.nix
  ];
}
