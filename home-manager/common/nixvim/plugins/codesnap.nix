{
  pkgs,
  lib,
  config,
  ...
}: {
  #FIXME: Plugin not working with shortcuts
  programs.nixvim.plugins = {
    codesnap = {
      lazyLoad = {
        settings = {
          cmd = [
            "CodeSnap"
            "CodeSnapSave"
            "CodeSnapHighlight"
            "CodeSnapSaveHighlight"
          ];
        };
      };

      settings = {
        code_font_family = "MonoLisa Nerd Font";
        save_path = "$XDG_PICTURES_DIR/screenshots";
        mac_window_bar = true;
        title = "CodeSnap.nvim";
        watermark = "";
        breadcrumbs_separator = "/";
        has_breadcrumbs = true;
        has_line_number = false;
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>c";
        mode = "v";
        group = "Codesnap";
        icon = "󰄄 ";
      }
    ];
  };

  programs.nixvim.keymaps = [
    {
      mode = "v";
      key = "<leader>cc";
      action = "<cmd>CodeSnap<CR>";
      options = {
        desc = "Copy";
      };
    }
    {
      mode = "v";
      key = "<leader>cs";
      action = "<cmd>CodeSnapSave<CR>";
      options = {
        desc = "Save";
      };
    }
    {
      mode = "v";
      key = "<leader>ch";
      action = "<cmd>CodeSnapHighlight<CR>";
      options = {
        desc = "Highlight";
      };
    }
    {
      mode = "v";
      key = "<leader>cH";
      action = "<cmd>CodeSnapSaveHighlight<CR>";
      options = {
        desc = "Save Highlight";
      };
    }
  ];
}
