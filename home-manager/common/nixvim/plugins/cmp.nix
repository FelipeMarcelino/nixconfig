{ config, pkgs, ...}:
{
  programs.nixvim.plugins.cmp = {
    autoEnableSources = true;
    settings.sources = [
      { name = "nvim_lsp"; }
      { name = "path"; }
      { name = "nvim_lsp_document_symbol" }
      { name = "nvim_lsp_signature_help" }
      { name = "buffer"; }
      { name = "cmdline_history"; }
      { name = "nvim_lua"; }
      { name = "luasnip" },
    ];
  }
}
