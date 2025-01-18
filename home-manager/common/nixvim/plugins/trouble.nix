{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.trouble = {
    autoLoad = true;
    settings = {
      auto_close = true;
      auto_refresh = true;
      focus = true;
      follow = true;
      open_no_results = true;
      modes = {
        preview_float = {
          mode = "diagnostics";
          preview = {
            type = "float";
            relative = "editor";
            border = "rounded";
            title = "Preview";
            title_pos = "center";
            position = [
              0
              (-2)
            ];
            size = {
              width = 0.4;
              height = 0.4;
            };
            zindex = 200;
          };
        };
      };
    };
  };

  programs.nixvim.plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>u";
      mode = "n";
      icon = "";
      group = "Trouble";
    }
  ];

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ud";
      action = "<cmd>Trouble preview_float toggle<cr>";
      options = {
        desc = "Diagnostics toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>uD";
      action = "<cmd>Trouble preview_float toggle filter.buf=0<cr>";
      options = {
        desc = "Buffer Diagnostics toggle";
      };
    }
  ];
}
