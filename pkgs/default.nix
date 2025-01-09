# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  pragmata-monolisa-fonts = pkgs.callPackage ./pragmata-monolisa-fonts {};
}
