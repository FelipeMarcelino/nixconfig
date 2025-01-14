{ config, lib, ... }:
{
  programs.nixvim.plugins = {
    harpoon = {
      enableTelescope = true;
      keymapsSilent = true;
      markBranch = true;
      excludedFiletypes = [
        "harpoon"
        "alpha"
        "NvimTree"
      ];
      saveOnChange = true;
      enterOnSendcmd = true;

      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<leader>he";
        navFile = {
          "1" = "<leader>hj";
          "2" = "<leader>hk";
          "3" = "<leader>hl";
          "4" = "<leader>hm";
        };
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>h";
        group = "Harpoon";
        icon = "󱡀 ";
      }
      {
        __unkeyed-1 = "<leader>ha";
        desc = "Add";
      }
      {
        __unkeyed-1 = "<leader>he";
        desc = "QuickMenu";
      }
      {
        __unkeyed-1 = "<leader>hj";
        desc = "1";
      }
      {
        __unkeyed-1 = "<leader>hk";
        desc = "2";
      }
      {
        __unkeyed-1 = "<leader>hl";
        desc = "3";
      }
      {
        __unkeyed-1 = "<leader>hm";
        desc = "4";
      }
    ];
  };
}
