{ config, lib, ... }:
{
  programs.nixvim.plugins = {
    git-worktree = {
      enable = true;
      enableTelescope = true;

      # TODO: migrate plugin to mkNeovimPlugin
      # lazyLoad.settings.keys = [
      #   "<leader>gw"
      #   "<leader>fg"
      #   "<leader>gWc"
      #   "<leader>gWs"
      # ];
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>gW";
        group = "Worktree";
        icon = "󰙅 ";
      }
    ];
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope git_worktree<CR>";
      options = {
        desc = "Git Worktree";
      };
    }
    {
      mode = "n";
      key = "<leader>gWc";
      action.__raw = ''
        function()
          require('telescope').extensions.git_worktree.create_git_worktree()
        end
      '';
      options = {
        desc = "Create worktree";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gWs";
      action.__raw = ''
        function()
          require('telescope').extensions.git_worktree.git_worktrees()
        end
      '';
      options = {
        desc = "Switch / Delete worktree";
        silent = true;
      };
    }
  ];
}
