{ config, pkgs, ... }:
{
  programs.nixvim.plugins.vim-matchup = {
    enableSurround = true;
    enableTransmute = true;
  };
}
