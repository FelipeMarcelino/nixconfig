{ config, pkgs, ... }:
{

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ui";
      action = "<cmd>IBLToggle<CR>";
      options = {
        desc = "Indent-Blankline toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>uI";
      action = "<cmd>IBLToggleScope<CR>";
      options = {
        desc = "Indent-Blankline Scope toggle";
      };
    }
  ];
}
