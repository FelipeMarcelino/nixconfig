{ lib, config, ... }:
{
  programs.nixvim.plugins = {
    grug-far = {
      enable = true;
      lazyLoad = {
        settings = {
          cmd = "GrugFar";
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>rg";
      action = "<cmd>GrugFar<CR>";
      options = {
        desc = "GrugFar toggle";
      };
    }
  ];
}
