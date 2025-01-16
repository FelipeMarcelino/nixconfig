{
  config,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {
    auto-save.enable = true;
    auto-session.enable = true;
    autoclose.enable = true;
    better-escape.enable = true;
    blink-cmp.enable = true;
    ## cmp-calc.enable = true;
    ## cmp-git.enable = true;
    ## cmp-spell.enable = true;
    ## cmp-zsh.enable = true;
    ## cmp-cmdline-history.enable = true;
    ## cmp-emoji.enable = true;
    ## cmp-nvim-lsp-signature-help.enable = true;
    ## copilot-cmp.enable = true;
    #cmp.enable = true;
    commentary.enable = true;
    copilot-lua.enable = true;
    copilot-chat.enable = true;
    conform-nvim.enable = true;
    csvview.enable = true;
    direnv.enable = true;
    friendly-snippets.enable = true;
    git-conflict.enable = true;
    #gitblame.enable = true;
    inc-rename.enable = true;
    indent-blankline.enable = true;
    lastplace.enable = true;
    lsp.enable = true;
    #lsp-signature.enable = true;
    lspkind.enable = true;
    ##lspsaga.enable = true;
    lz-n.enable = true;
    lualine.enable = true;
    ##luasnip.enable = true;
    neoscroll.enable = true;
    noice.enable = true;
    nix.enable = true;
    nix-develop.enable = true;
    nvim-autopairs.enable = true;
    colorizer.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    treesitter-context.enable = true;
    treesitter-refactor.enable = true;
    treesitter-textobjects.enable = true;
    spectre.enable = true;
    project-nvim.enable = true;
    markdown-preview.enable = true;
    gitmessenger.enable = true;
    gitsigns.enable = true;
    neo-tree.enable = true;
    diffview.enable = true;
    notify.enable = true;
    cursorline.enable = true;
    harpoon.enable = true;
    vim-matchup.enable = true;
    #sniprun.enable = true;
    nvim-bqf.enable = true;
    undotree.enable = true;
    which-key.enable = true;
    trouble.enable = true;
    refactoring.enable = true;
    web-devicons.enable = true;
    #zellij.enable = true;
    zk.enable = true;
    #wilder.enable = true;
    yazi.enable = true;
    vim-surround.enable = true;
    bufferline.enable = true;
    codesnap.enable = true;
    debugprint.enable = true;
    fastaction.enable = true;
    flash.enable = true;
    git-worktree.enable = true;
    gitignore.enable = true;
  };

  programs.nixvim.extraPlugins = [
    #    pkgs.vimPlugins.blink-ripgrep-nvim
  ];
}
