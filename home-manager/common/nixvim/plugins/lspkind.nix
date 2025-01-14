{ config, pkgs, ... }:
{

  programs.nixvim.plugins.lspkind = {
    cmp.enable = true;
    menu = {
      buffer = "";
      calc = "";
      cmdline = "";
      codeium = "󱜙";
      copilot = "";
      emoji = "󰞅";
      git = "";
      luasnip = "󰩫";
      neorg = "";
      nvim_lsp = "";
      nvim_lua = "";
      path = "";
      spell = "";
      treesitter = "󰔱";
      nixpkgs_maintainers = "";
    };
  };
}
