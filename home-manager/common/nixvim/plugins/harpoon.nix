{
  config,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    harpoon = {
      enableTelescope = true;

      settings = {
        keymapsSilent = true;
        markBranch = true;
        saveOnToggle = false;
        excludedFiletypes = [
          "harpoon"
          "alpha"
          "NvimTree"
        ];
        saveOnChange = true;
        enterOnSendcmd = true;
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

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ha";
      action.__raw = "function() require'harpoon':list():add() end";
    }
    {
      mode = "n";
      key = "<leader>hq";
      action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
    }
    {
      mode = "n";
      key = "<h-j>";
      action.__raw = "function() require'harpoon':list():select(1) end";
    }
    {
      mode = "n";
      key = "<h-k>";
      action.__raw = "function() require'harpoon':list():select(2) end";
    }
    {
      mode = "n";
      key = "<h-l>";
      action.__raw = "function() require'harpoon':list():select(3) end";
    }
    {
      mode = "n";
      key = "<h-m>";
      action.__raw = "function() require'harpoon':list():select(4) end";
    }
  ];
}
