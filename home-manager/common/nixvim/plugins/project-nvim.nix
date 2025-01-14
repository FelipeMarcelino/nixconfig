{ config, lib, ... }:
{
  programs.nixvim.plugins.project-nvim = {
    enable = true;
    enableTelescope = true;

    # TODO: fix lazy loading
    # lazyLoad.settings.cmd = "Telescope projects";
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>fp";
      action = "<cmd>Telescope projects<CR>";
      options = {
        desc = "Find projects";
      };
    }
  ];
}
