{ config, pkgs, ...}:
{
  programs.nixvim.plugins.treesitter = {
    autoLoad = true;
    folding = true;
    settings = {
      highlight.enable = true;
      incremental_selection.enable = true;
      indent.enable = true;
    };
  };
}
