{
  config,
  lib,
  ...
}: {
  programs.nixvim.plugins.toggleterm = {
    lazyLoad = {
      settings = {
        cmd = "ToggleTerm";
        keys = [
          "<leader>tg"
          "<leader>gg"
        ];
      };
    };

    settings = {
      direction = "float";
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>ToggleTerm<CR>";
      options = {
        desc = "Open Terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>tg";
      action.__raw = ''
        function()
          local toggleterm = require('toggleterm.terminal')

          toggleterm.Terminal:new({cmd = 'lazygit',hidden = true}):toggle()
        end
      '';
      options = {
        desc = "Open Lazygit";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gg";
      action.__raw = ''
        function()
          local toggleterm = require('toggleterm.terminal')

          toggleterm.Terminal:new({cmd = 'lazygit',hidden = true}):toggle()
        end
      '';
      options = {
        desc = "Open Lazygit";
        silent = true;
      };
    }
  ];
}
