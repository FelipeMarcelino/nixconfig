{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.taskwarrior or { enable = false; };
in
{
  options.home.programs.taskwarrior = mkOption {
    description = "Enable taskwarrior, a task manager. In also enables tui option (taskwarrior-tui)";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
      dataLocation = "$XDG_TASKWARRIOR_DIR";
      colorTheme = ./taskwarrior-catppuccin-theme.theme;
      config = {
        weekstart = "monday";
      };
    };

    home.packages = with pkgs; [
      taskwarrior-tui
    ];

    systemd.user.tmpfiles.rules = [
      "d ${config.home.homeDirectory}/Taskwarrior/ 0755 felipemarcelino wheel - -"
    ];

    programs.zsh.shellAliases = {
      rnd = "task add +rnd +next +@computer +@online";
    };

    programs.zsh.initExtra = ''

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

  };

}
