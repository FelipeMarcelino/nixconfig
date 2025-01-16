{ config, pkgs, ... }:
{
  programs.nixvim.plugins = {
    illuminate = {

      # TODO: migrate to mkNeovimPlugin
      # lazyLoad.settings.event = "DeferredUIEnter";

      filetypesDenylist = [
        "dirvish"
        "fugitive"
        "neo-tree"
        "TelescopePrompt"
      ];
      largeFileCutoff = 3000;
    };
  };
}
