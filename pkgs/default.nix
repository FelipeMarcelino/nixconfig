# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, inputs }:
{
  pragmata-monolisa-fonts = pkgs.callPackage ./pragmata-monolisa-fonts { };
  mpv-custom-fonts = pkgs.callPackage ./mpv-custom-fonts { };
  rtk = pkgs.callPackage ./rtk { };
  codex = inputs.nixpkgs-codex.legacyPackages.${pkgs.stdenv.hostPlatform.system}.codex;
}
