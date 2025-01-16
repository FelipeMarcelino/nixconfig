{ config, pkgs, ... }:
{
  imports = [
    ./pylsp.nix
    ./typos-lsp.nix
    ./harper.nix
    ./nil-ls.nix
    ./statix.nix
    ./ruff.nix
  ];
}
