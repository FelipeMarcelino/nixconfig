{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.cmp = {
    autoEnableSources = true;
    settings.performance = {
      debounce = 200;
      max_view_entries = 200;
      throttle = 500;
      fetching_timeout = 200;
      confirm_resolve_timeout = 800;
    };
    settings = {
      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "nvim_lsp_document_symbol";}
        {name = "nvim_lsp_signature_help";}
        {name = "buffer";}
        {name = "cmdline_history";}
        {name = "nvim_lua";}
        {name = "luasnip";}
      ];

      settings.window.documentation.border = "rounded";
      settings.window.completion.border = "double";

      # mapping = {
      #   "<C-Space>" = "cmp.mapping.complete()";
      #   "<C-d>" = "cmp.mapping.scroll_docs(-4)";
      #   "<C-e>" = "cmp.mapping.close()";
      #   "<C-f>" = "cmp.mapping.scroll_docs(4)";
      #   "<CR>" = "cmp.mapping.confirm({ select = true })";
      #   "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      #   "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      # };
    };
  };
}
