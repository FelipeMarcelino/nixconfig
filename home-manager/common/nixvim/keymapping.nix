{
  config,
  pkgs,
  ...
}:
{
  programs.nixvim.globals.mapleader = " ";
  programs.nixvim.globals.localleader = "\\";
  programs.nixvim.keymaps = [
    {
      key = ";";
      action = ":";
    }
    {
      key = "<Space>";
      action = "<NOP>";
    }
    {
      key = "<BS>";
      action = "<BS>x";
    }
    {
      key = "Y";
      action = "y$";
    }
    {
      key = "<C-c>";
      action = "<cmd>b#<CR>";
    }
    {
      key = "<C-[>";
      action = "<cmd>cnext<CR>";
    }
    {
      key = "<C-]>";
      action = "<cmd>cprev<CR>";
    }
    {
      action = ":w<CR>";
      key = "<leader>s";
      options.silent = true;
    }
    {
      action = ":wa!<CR>";
      key = "<leader>S";
      options.silent = true;
    }
    {
      action = ":w<CR>";
      key = "<C-s>w";
      options.silent = true;
    }
    {
      action = ":split<CR>";
      key = "vs";
      options.silent = true;
    }
    {
      action = ":vsplit<CR>";
      key = "vv";
      options.silent = true;
    }
    {
      action = ":bd<CR>";
      key = "<leader>bq";
      options.silent = true;
    }
    {
      action = "<C-w>h";
      key = "<C-h>";
      options.silent = true;
    }
    {
      action = "<C-w>j";
      key = "<C-j>";
      options.silent = true;
    }
    {
      action = "<C-w>l";
      key = "<C-l>";
      options.silent = true;
    }
    {
      action = "<C-w>k";
      key = "<C-k>";
      options.silent = true;
    }
    {
      action = ":vertical resize +2<CR>";
      key = "<C-Left>";
      options.silent = true;
    }
    {
      action = ":vertical resize -2<CR>";
      key = "<C-Right>";
      options.silent = true;
    }
    {
      action = ":resize +2<CR>";
      key = "<C-Down>";
      options.silent = true;
    }
    {
      action = ":resize -2<CR>";
      key = "<C-Up>";
      options.silent = true;
    }
    {
      key = "<C-n>";
      action = "<Cmd>enew<CR>";
    }
    {
      action = "(v:count == 0 ? 'gj' : 'j')";
      key = "j";
      options.silent = true;
      options.expr = true;
    }
    {
      action = "(v:count == 0? 'gk' : 'k')";
      key = "k";
      options.silent = true;
      options.expr = true;
    }
    {
      action = ":m '>+1<CR>gv=gv";
      key = "J";
      options.silent = true;
      mode = "v";
    }
    {
      action = ":m '<-2<CR>gv=gv";
      key = "K";
      options.silent = true;
      mode = "v";
    }
    {
      action = "<gv";
      key = "<s-tab>";
      options.silent = true;
      mode = "x";
    }
    {
      action = ">gv";
      key = "<tab>";
      options.silent = true;
      mode = "x";
    }
    {
      action = "Nzzzv";
      key = "N";
      options.silent = true;
    }
    {
      action = "nzzzv";
      key = "n";
      options.silent = true;
    }
    {
      key = "<leader>Q";
      action = "<Cmd>q!<CR>";
    }
    {
      action = "";
      key = "<M-Q>";
      mode = "";
      options.noremap = false;
      options.unique = true;
    }
    {
      action = ":nohl<CR>";
      key = "<esc>";
      options.silent = true;
      options.noremap = false;
      options.unique = true;
    }
    {
      action = "p`]";
      key = "p";
      options.silent = true;
    }
    {
      action = "y`]";
      key = "y";
      options.silent = true;
      mode = "v";
    }
    {
      action = "py`]";
      key = "p";
      options.silent = true;
      mode = "v";
    }
    {
      action = "\"+p";
      key = "<leader>p";
      options.silent = true;
      options.noremap = false;
    }
    {
      action = "\"+y";
      key = "<leader>y";
      options.silent = true;
      options.noremap = false;
    }
    {
      action = ":q<CR>";
      key = "<C-q>";
      options.silent = true;
      options.noremap = false;
    }
    {
      action = ":bprevious<CR>";
      key = "[b";
      options.silent = true;
    }
    {
      action = ":bnext<CR>";
      key = "]b";
      options.silent = true;
    }
    {
      key = "<TAB>";
      action = "<cmd>bnext<CR>";
    }
    {
      key = "<S-TAB>";
      action = "<cmd>bprevious<CR>";
    }

    {
      action = ":ZkNew { title = vim.fn.input('Title: ')}<CR>";
      key = "<leader>zn";
      options.silent = true;
      desc = "Create a new note with specified title";
    }
    {
      action = ":ZkNotes { sort = {'modified'} }<CR>";
      key = "<leader>zo";
      options.silent = true;
      desc = "Open zk notes without search";
    }
    {
      action = ":ZkTags<CR>";
      key = "<leader>zt";
      options.silent = true;
      desc = "Open tags";
    }
    {
      action = ":ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>";
      key = "<leader>zf";
      options.silent = true;
      desc = "Opens notes sorted by modified date with search ";
    }
    {
      action = ":'<,'>ZkMatch<CR>";
      key = "<leader>zf";
      options.silent = true;
      mode = "v";
      desc = " Opens a notes picker, filters for notes that match the text in the last visual selection ";
    }
  ];

  files."after/ftplugin/markdown.lua" = {
    keymaps = [
      {
        mode = "n";
        key = "<CR>";
        action.__raw = "vim.lsp.buf.definition";
        desc = "Go to note (definition)";
      }
      {
        action = ":ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>";
        key = "<leader>zn";
        options.silent = true;
        desc = "Create a note with a specified title";
      }
      {
        action = ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>";
        key = "<leader>znt";
        options.silent = true;
        mode = "v";
        desc = "Create a note with the title from visual selected text";
      }
      {
        action = ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>";
        key = "<leader>znc";
        options.silent = true;
        mode = "v";
        desc = "Create a new note using the visual selected text as content";
      }
      {
        action = "<Cmd>ZkBacklinks<CR>";
        key = "<leader>zb";
        options.silent = true;
        desc = "Show notes backlinks";
      }
      {
        action = "<Cmd>ZkLinks<CR>";
        key = "<leader>zl";
        options.silent = true;
        desc = "Show notes links";
      }
      {
        action = ":'<,'>lua vim.lsp.buf.range_code_action()<CR>";
        key = "<leader>za";
        options.silent = true;
        mode = "v";
      }
    ];
  };
}
