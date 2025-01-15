{
  config,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins.lsp.servers = {
    bashls.enable = true;
    #pylyzer.enable = true;
    pylsp.enable = true;
    zk.enable = true;
    dockerls.enable = true;
    jsonls.enable = true;
    lua_ls.enable = true;
    marksman.enable = true;
    nil_ls.enable = true;
    ruff.enable = true;
    sqls.enable = true;
    yamlls.enable = true;
  };

  programs.nixvim.plugins.lsp.inlayHints = true;
  programs.nixvim.plugins.lsp.keymaps.silent = true;

  programs.nixvim.plugins.lsp.keymaps.diagnostic = {
    "<leader>l[" = "goto_prev";
    "<leader>l]" = "goto_next";
    "<leader>lH" = "open_float";
  };

  programs.nixvim.plugins.lsp.keymaps.extra = [
    {
      action.__raw = ''vim.lsp.buf.format'';
      mode = "v";
      key = "<leader>lf";
      options = {
        silent = true;
        buffer = false;
        desc = "Format selection";
      };
    }

    {
      action = "<CMD>PeekDefinition textDocument/definition<CR>";
      mode = "n";
      key = "<leader>lp";
      options = {
        desc = "Preview definition";
      };
    }
    {
      action = "<CMD>PeekDefinition textDocument/typeDefinition<CR>";
      mode = "n";
      key = "<leader>lP";
      options = {
        desc = "Preview type definition";
      };
    }
  ];

  programs.nixvim.plugins.lsp.keymaps.lspBuf = {
    "<leader>ld" = "definition";
    "<leader>lD" = "references";
    "<leader>lf" = "format";
    "<leader>lh" = "hover";
    "<leader>li" = "implementation";
    "<leader>lr" = "rename";
    "<leader>lt" = "type_definition";
    "<leader>la" = "code_action";
  };

  programs.nixvim.plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>l";
      group = "LSP";
      icon = " ";
    }
    {
      __unkeyed-1 = "<leader>la";
      desc = "Code Action";
    }
    {
      __unkeyed-1 = "<leader>ld";
      desc = "Definition";
    }
    {
      __unkeyed-1 = "<leader>lD";
      desc = "References";
    }
    {
      __unkeyed-1 = "<leader>lf";
      desc = "Format";
    }
    {
      __unkeyed-1 = "<leader>l[";
      desc = "Prev";
    }
    {
      __unkeyed-1 = "<leader>l]";
      desc = "Next";
    }
    {
      __unkeyed-1 = "<leader>lt";
      desc = "Type Definition";
    }
    {
      __unkeyed-1 = "<leader>li";
      desc = "Implementation";
    }
    {
      __unkeyed-1 = "<leader>lh";
      desc = "Lsp Hover";
    }
    {
      __unkeyed-1 = "<leader>lH";
      desc = "Diagnostic Hover";
    }
    {
      __unkeyed-1 = "<leader>lr";
      desc = "Rename";
    }
  ];
}
