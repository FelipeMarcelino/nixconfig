{ lib, config, ... }:
{
  programs.nixvim.plugins = {
    spectre = {
      enable = true;
      lazyLoad = {
        settings = {
          cmd = "Spectre";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>rs";
      action = "<cmd>Spectre<CR>";
      options = {
        desc = "Spectre toggle";
      };
    }
  ];
}
