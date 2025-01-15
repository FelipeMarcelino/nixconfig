{ config, pkgs, ... }:
{
  imports = [
    ./pylsp.nix
    ./typos-lsp.nix
  ];
}
