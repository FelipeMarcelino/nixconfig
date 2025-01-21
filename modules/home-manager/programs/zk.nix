{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.zettelkasten or { enable = false; };
in
{
  options.home.programs.zettelkasten = mkOption {
    description = "Enable zettelkasten (zk). Notes are located in $HOME/Zettelkasten. Change the author on module file.";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zk = {

      enable = true;
      settings = {
        notebook = {
          dir = "${config.home.homeDirectory}/Zettelkasten";
        };
        note = {
          language = "en";
          default-title = "untitled";
          filename = "{{id}}-{{slug title}}";
          extension = "md";
          template = "default.md";
          id-charset = "alphanum";
          id-length = 4;
          id-case = "lower";
        };
        extra.author = "Felipe Marcelino";
        format.markdown = {
          hashtags = true;
          colon-tags = true;
        };
        tool = {
          editor = "nvim";
          fzf-preview = "bat -p --color always {-1}";
        };
        alias = {
          edlast = "zk edit --limit 1 --sort modified- $@";
          recent = "zk edit --sort created --created-after 'last two weeks' --interactive";
          lucky = "zk list --quiet --format full --sort random --limit 1";
          ls = "zk list $@";
          ed = "zk edit $@";
          n = "zk new $@";
          paths = "zk list --quiet --format \"'{{path}}'\" --delimiter ' ' $@";
          inline = "zk list --quiet --format {{path}} --delimiter , $@";
          nt = "zk new --title \"$*";
          bl = "zk list --link-to $@";
          unliked-mentions = "zk list --mentioned-by $1 --no-linked-by $1";
          log = "zk list --quiet --format path --delimiter0 $@ | xargs -0 git log --patch --";
          save = "git add . && git commit -m \"$*\"";
          cp = ''mkdir -p "$1" && zk list --quiet --format path --delimiter0 \$\{@:2\} | xargs -t -0 -I % cp --parents "%" "$1"'';
          daily = ''zk new --no-input "$ZK_NOTEBOOK_DIR/journal/daily"'';
        };
        lsp.diagnostics = {
          wiki-title = "hint";
          dead-link = "error";
        };
        lsp.completion = {
          note-label = "{{title-or-path}}";
          note-filter-text = "{{title}} {{path}}";
          note-detail = "{{filename-stem}}";
        };
        group.journal = {
          paths = [
            "journal/weekly"
            "journal/daily"
          ];
        };
        group.journal.note = {
          filename = "{{format-date now '%Y-%m-%d'}}";
          template = "daily.md";
          extension = "md";
        };
      };
    };

    systemd.user.tmpfiles.rules = [
      "d ${config.home.homeDirectory}/Zettelkasten/ 0755 felipemarcelino wheel - -"
      "d ${config.home.homeDirectory}/Zettelkasten/journal/daily 0755 felipemarcelino wheel - -"
    ];

    home.file."${config.home.homeDirectory}/.config/zk/templates/daily.md".text = ''
      # {{format-date now "long"}}

      What did I do today? Or anything else
    '';
  };
}
