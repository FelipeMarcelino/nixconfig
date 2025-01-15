{
  lib,
  config,
  ...
}:
{
  programs.nixvim.plugins = {
    spectre = {
      lazyLoad = {
        settings = {
          cmd = "Spectre";
        };
      };
    };
  };

  programs.nixvim.keymaps = [
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
