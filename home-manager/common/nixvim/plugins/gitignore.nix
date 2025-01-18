{
  config,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    gitignore = {
      # TODO: migrate to mkNeovimPlugin
      # lazyLoad.settings.keys = [ "<leader>gi" ];
      # lazyLoad.settings.cmd = [ "Gitignore" ];
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gi";
      action.__raw = ''require('gitignore').generate'';
      options = {
        desc = "Gitignore generate";
        silent = true;
      };
    }
  ];
}
