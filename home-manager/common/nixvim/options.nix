{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.opts = {
    autoread = true;
    hidden = true;
    smarttab = true;
    splitright = true;
    splitbelow = true;
    expandtab = true;
    cursorline = true;
    tabstop = 4;
    shiftwidth = 4;
    softtabstop = 4;
    textwidth = 120;
    scrolloff = 8;
    sidescrolloff = 20;
    sidescroll = 5;
    showmode = false;
    showmatch = true;
    gdefault = true;
    title = true;
    ch = 3;
    showbreak = "↪ ";
    iskeyword = "-,_";
    shiftround = true;
    writebackup = false;
    swapfile = false;
    breakindent = true;
    smartindent = true;
    wrap = false;
    shortmess = "filnxtToOFc";
    diffopt = "internal,filler,closeoff,vertical,iwhite,hiddenoff";
    relativenumber = true;
    number = true;
    listchars = "tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮";
    wildmode = "list:longest,list:full";
    foldmethod = "expr";
    foldnestmax = 10;
    foldlevelstart = 1;
    foldlevel = 1;
    foldenable = false;
    list = true;
  };
}
