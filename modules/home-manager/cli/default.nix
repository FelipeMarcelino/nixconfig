{ pkgs, ... }:
{
  imports = [
    ./eza.nix
    ./zoxide.nix
    ./bat.nix
    ./fzf.nix
    ./starship.nix
    ./git.nix
    ./aws.nix
  ];
}
