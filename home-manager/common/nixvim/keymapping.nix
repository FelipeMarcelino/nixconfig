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
      key = "<C-S-l>";
      options.silent = true;
    }
    {
      action = ":vertical resize -2<CR>";
      key = "<C-S-h>";
      options.silent = true;
    }
    {
      action = ":resize +2<CR>";
      key = "<C-S-j>";
      options.silent = true;
    }
    {
      action = ":resize -2<CR>";
      key = "<C-S-k>";
      options.silent = true;
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
  ];
}
