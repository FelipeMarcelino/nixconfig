{ config, pkgs, ... }:
{
  imports = [
    ./pylsp.nix
    ./typos-lsp.nix
    ./harper.nix
    ./nix-ls.nix
    ./statix.nix
  ];
}
