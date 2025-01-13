{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.blink-cmp-copilot.enable = true;
  programs.nixvim.plugins.blink-compat.enable = true;
  programs.nixvim.plugins.blink-cmp.settings = {
    appearance = {
      nerd_font_variant = "normal";
      use_nvim_cmp_as_default = true;
    };
    completion = {
      accept = {
        auto_brackets = {
          enabled = true;
          semantic_token_resolution = {
            enabled = false;
          };
        };
      };
      documentation = {
        auto_show = true;
      };
    };
    keymap = {
      preset = "enter";
      "<A-Tab>" = [
        "snippet_forward"
        "fallback"
      ];
      "<A-S-Tab>" = [
        "snippet_backward"
        "fallback"
      ];
      "<Tab>" = [
        "select_next"
        "fallback"
      ];
      "<S-Tab>" = [
        "select_prev"
        "fallback"
      ];
    };
    signature = {
      enabled = true;
      window.border = "rounded";
    };
    sources.default = [
      "lsp"
      "path"
      "snippets"
      "buffer"
      "luasnip"
      # Community
      #"emoji"
      "copilot"
      #"ripgrep"
      # Cmp sources
      # TODO: migrate when available
      "calc"
      "git"
      "spell"
      "zsh"
    ];
    sources.providers = {
      # BUILT-IN SOURCES
      lsp.score_offset = 4;
      # Community sources
      copilot = {
        name = "copilot";
        module = "blink-cmp-copilot";
        async = true;
        score_offset = 100;
      };
      # emoji = {
      #   name = "Emoji";
      #   module = "blink-emoji";
      #   score_offset = 1;
      # };
      # ripgrep = {
      #   name = "Ripgrep";
      #   module = "blink-ripgrep";
      #   score_offset = 1;
      # };
      # Cmp sources
      calc = {
        name = "calc";
        module = "blink.compat.source";
        score_offset = 2;
      };
      git = {
        name = "git";
        module = "blink.compat.source";
        score_offset = 0;
      };
      npm = {
        name = "npm";
        module = "blink.compat.source";
        score_offset = -3;
      };
      spell = {
        name = "spell";
        module = "blink.compat.source";
        score_offset = -1;
      };
      zsh = {
        name = "zsh";
        module = "blink.compat.source";
        score_offset = -3;
      };

      cmdline_history = {
        name = "cmdline_history";
        module = "blink.compat.source";
        score_offset = 0;
      };
    };
  };

  programs.nixvim.plugins.lsp.capabilities =
    # Lua
    ''
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
    '';
}
