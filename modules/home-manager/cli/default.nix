{ pkgs, ...}: 
{
    programs.zoxide = {
    	enable = true;
	enableZshIntegration = true;
    };

    programs.eza = {
    enable = true;
    #enableAliases = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--smart-group"
      "--header"
      "--git-repos"
      "--total-size"
      "--git"
      "--header"
      "--hyperlink"
      "--tree"
    ];
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batpipe prettybat];
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "fd";
    defaultOptions = ["--border" "--height 60%" "--layout=reverse" "--info=inline" "--margin 1" "--padding 1"];
    fileWidgetOptions = ["--preview 'bat -n --color=always {}'"];
  };

  programs.starship.enable = true;

  home.packages = with pkgs; [
    coreutils
    fd
    htop
    httpie
    jq
    procs
    ripgrep
    tldr
    zip
    fasd
    duf 
    dust
  ];



}
