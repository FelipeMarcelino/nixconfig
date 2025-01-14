{ config, pkgs, ... }:
{
  programs.nixvim.plugins.nvim-autopairs = {
    check_ts = true;
  };
}
