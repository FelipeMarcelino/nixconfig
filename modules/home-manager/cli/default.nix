{ pkgs, ... }:
{
  imports = [
    ./eza.nix
    ./zoxide.nix
    ./bat.nix
    ./fzf.nix
    ./starship.nix
    ./git.nix
    ./ghostty.nix
  ];
}
