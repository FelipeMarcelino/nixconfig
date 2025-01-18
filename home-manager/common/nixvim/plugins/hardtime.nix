{
  config,
  lib,
  ...
}: let
  cfg = config.plugins.hardtime;
in {
  programs.nixvim.plugins = {
    hardtime = {
      enable = true;

      # FIXME: runtime error on requiring module
      # lazyLoad.settings.cmd = "Hardtime";

      settings = {
        # NOTE: Default to off now.
        disable_mouse = false;
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>v";
        mode = "n";
        group = "Vim training";
        icon = "󱛊";
      }
    ];
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>vh";
      action.__raw = ''
        function ()
          vim.g.disable_hardtime = not vim.g.disable_hardtime
          if vim.g.disable_hardtime then
            require("hardtime").disable()
          else
            require("hardtime").enable()
          end
          vim.notify(string.format("Hardtime %s", bool2str(not vim.g.disable_hardtime), "info"))
        end
      '';
      options = {
        desc = "Hardtime toggle";
        silent = true;
      };
    }
  ];
}
