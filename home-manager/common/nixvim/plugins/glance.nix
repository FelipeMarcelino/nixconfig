{
  config,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    glance = {

      lazyLoad.settings.cmd = "Glance";

      settings = {
        border.enable = true;
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>lg";
        group = "Glance";
        icon = "󰍉";
      }
    ];
  };

  programs.nixvim.keymaps = [
    {
      action = "<CMD>Glance definitions<CR>";
      mode = "n";
      key = "<leader>lgd";
      options = {
        desc = "Glance definition";
      };
    }
    {
      action = "<CMD>Glance implementations<CR>";
      mode = "n";
      key = "<leader>lgi";
      options = {
        desc = "Glance implementation";
      };
    }
    {
      action = "<CMD>Glance references<CR>";
      mode = "n";
      key = "<leader>lgr";
      options = {
        desc = "Glance reference";
      };
    }
    {
      action = "<CMD>Glance type_definitions<CR>";
      mode = "n";
      key = "<leader>lgt";
      options = {
        desc = "Glance type definition";
      };
    }
  ];
}
