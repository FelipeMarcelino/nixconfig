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
      };
    };

    systemd.user.tmpfiles.rules = [
      "d ${config.home.homeDirectory}/Zettelkasten/ 0755 felipemarcelino wheel - -"
    ];
  };
}
