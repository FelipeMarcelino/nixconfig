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

        urgency.user.tag."in".coefficient = 15.0;
        report."in".columns = "id,description";
        report."in".description = "Inbox";
        report."in".filter = "status:pending limit:page (+in)";
        report."in".labels = "ID,Description";

        uda.brainpower.type = "string";
        uda.brainpower.label = "Brainpower";
        uda.brainpower.values = "H,M,L";

        report.next.description = "Most urgent tasks";
        report.next.columns = "id,start.age,entry.age,urgency,priority,depends,project,tags,recur,scheduled.countdown,due.remaining,until.remaining,description,brainpower";
        report.next.filter = "status:pending and +next";
        report.next.labels = "ID, Active, Age, Urgency,Deps,P,Project,Tag,Recur,S,Due, Until,Description,Brainpower";
        report.next.sort = "brainpower-,priority-,urgency-";

        uda.estimate.type = "numeric";
        uda.estimate.label = "Estimate";

        context.work = "@work";
        context.home = "-@work";
        context.computer = "@computer";
        context.dosomethingout = "-@computer";
        context.workoutside = "@work -@computer";
        context.partner = "@isabel";

        uda.taskwarrior-tui.shortcuts."1" = "remove-in";
        uda.taskwarrior-tui.keyconfig.shortcut1 = "i";
      };
    };

    home.packages = with pkgs; [
      taskwarrior-tui
      html-xml-utils
      (writeShellScriptBin "remove-in" ''
        ${pkgs.taskwarrior3}/bin/task "$@"  modify -in
      '')
    ];

    systemd.user.tmpfiles.rules = [
      "d ${config.home.homeDirectory}/Taskwarrior/ 0755 ${config.home.username} wheel - -"
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
        echo "Fetching URL: $1" >&2  # Print the URL being fetched
        wget -qO- "$1" | hxselect -s '\n' -c 'title' 2>/dev/null
      }

      read_and_review (){
        link="$1"
        title=$(webpage_title "$link")
        echo "$title"
        descr="\"Read and review: $title\""
        id=$(task add +next +rnr "$descr" | sed -n 's/Created task \(.*\)./\1/p')
        task "$id" annotate "$link"
      }

      alias rnr=read_and_review
    '';

  };

}
