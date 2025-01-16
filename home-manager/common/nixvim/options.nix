{
  config,
  pkgs,
  ...
}:
{
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
    showtabline = 2;
    lazyredraw = false;
    synmaxcol = 240;
    spell = true;
    cursorcolumn = false;
    spelllang = "en_us";
    laststatus = 3;
    backup = false;
    modeline = true;
    modelines = 100;
    mouse = "a";
    mousemodel = "extend";
    showmatch = true;
    gdefault = true;
    title = true;
    cmdheight = 0;
    copyindent = true;
    history = 100;
    ch = 3;
    showbreak = "↪ ";
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
    foldlevelstart = -1;
    foldlevel = 99;
    foldenable = true;
    list = true;
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,localoptions";

    fillchars = {
      horiz = "━";
      horizup = "┻";
      horizdown = "┳";
      vert = "┃";
      vertleft = "┫";
      vertright = "┣";
      verthoriz = "╋";

      eob = " ";
      diff = "╱";

      fold = " ";
      foldopen = "";
      foldclose = "";

      msgsep = "‾";
    };

    completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];
    pumblend = 10;
    pumheight = 10;
    pumwidth = 20;
  };
}
