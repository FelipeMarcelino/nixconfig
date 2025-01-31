{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.fzf.enableZshIntegration = true;
  programs.nix-index.enableZshIntegration = true;
  programs.skim.enableZshIntegration = true;
  programs.starship.enableZshIntegration = true;
  programs.direnv.enableZshIntegration = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.enableVteIntegration = true;
  programs.zsh.historySubstringSearch.enable = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.zsh-abbr.enable = true;
  programs.dircolors.enableZshIntegration = true;
  programs.zsh.defaultKeymap = "viins";
  programs.zsh.dirHashes = {
    docs = "$HOME/Documents";
    vids = "$HOME/Videos";
    dl = "$HOME/Downloads";
    pics = "$HOME/Pictures";
    proj = "$HOME/Projects";
    mus = "$HOME/Music";
    dot = "$HOME/Project/nixconfig";
  };
  programs.zsh.history.extended = true;
  programs.zsh.historySubstringSearch.searchDownKey = [ ];
  programs.zsh.initExtraBeforeCompInit = ''
    fpath+="$HOME/.zsh/completions"
  '';
  programs.zsh.historySubstringSearch.searchUpKey = [ ];
  programs.zsh.oh-my-zsh.plugins = [
    "sudo"
    "vi-mode"
    "scala"
    "sbt"
    "python"
    "colored-man-pages"
    "cp"
    "aliases"
    "alias-finder"
    "common-aliases"
    "fasd"
    "git"
  ];

  programs.zsh.plugins = [
    {
      name = "forgit";
      src = pkgs.fetchFromGitHub {
        owner = "wfxr";
        repo = "forgit";
        rev = "23.09.0";
        sha256 = "WvJxjEzF3vi+YPVSH3QdDyp3oxNypMoB71TAJ7D8hOQ=";
      };
      file = "forgit.plugin.zsh";
    }
  ];
  programs.zsh.initExtra = ''
    bindkey '^ ' autosuggest-accept
    zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
    zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
    zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
    zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

    tickle() {
      deadline=$1
      shift
      task add +in wait:$deadline "$@"
    }

    alias tick="tickle"
    alias think='tickle +1d'

    webpage_title (){
      wget -qO- "$\*" | hxselect -s '\n' -c 'title' 2>/dev/null
    }

    read_and_review (){
      link="$1"
      title=$(webpage_title $link)
      echo $title
      descr="\"Read and review: $title\""
      id=$(task add +next +rnr "$descr" | sed -n 's/Created task \(.\*\)./\1/p')
      task "$id" annotate "$link"
    }

    alias rnr=read_and_review

  '';

  programs.zsh.loginExtra = ''
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
  '';
  programs.zsh.shellAliases = {
    cat = "bat --paging=never";
    rnd = "task add +rnd +next +@computer +@online";
    l = "ls -lh";
    rm = "echo 'This is not the command you are looking for. Use tp'; false";
    tp = "trash-put";
    du = "dust";
    df = "duf";
    "in" = "task add +in";
    ttui = "taskwarrior-tui";
    o = "xdg-open";
  };
  programs.zsh.localVariables = {
    KEYTIMEOUT = 15;
  };
}
