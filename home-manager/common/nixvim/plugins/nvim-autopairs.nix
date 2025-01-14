{ config, pkgs, ... }:
{
  programs.nixvim.plugins.nvim-autopairs.settings = {
    check_ts = true;
  };
}
