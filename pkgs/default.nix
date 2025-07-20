# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, ... }:

{
  pragmata-monolisa-fonts = pkgs.callPackage ./pragmata-monolisa-fonts { };
  mpv-custom-fonts = pkgs.callPackage ./mpv-custom-fonts { };
  patch-nerd-font = pkgs.callPackage ./patch-nerd-font { };
}

