{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    auto-save.enable = true;
    auto-session.enable = true;
    autoclose.enable = true;
    better-escape.enable = true;
    blink-cmp.enable = true;
    #cmp.enable = true;
    commentary.enable = true;
    conform-nvim.enable = true;
    csvview.enable = true;
    direnv.enable = true;
    friendly-snippets.enable = true;
    git-conflict.enable = true;
    gitblame.enable = true;
    gitgutter.enable = true;
    inc-rename.enable = true;
    indent-blankline.enable = true;
    lastplace.enable = true;
    lsp.enable = true;
    lsp-signature.enable = true;
    lspkind.enable = true;
    lspsaga.enable = true;
    lualine.enable = true;
    luasnip.enable = true;
    neoscroll.enable = true;
    nix.enable = true;
    nvim-autopairs.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    treesitter-context.enable = true;
    web-devicons.enable = true;
    zellij.enable = true;
    zk.enable = true;
  };
}
