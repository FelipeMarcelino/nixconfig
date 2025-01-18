{
  pkgs,
  config,
  ...
}: {
  programs.nixvim.plugins.auto-session = {
    settings.log_level = "info";
    settings.auto_restore = true;
    settings.auto_save = true;
    settings.auto_session = {
      enabled = true;
      enable_last_session = false;
      use_git_branch = true;
      create_enabled = true;
      suppress_dirs = [
        "~/.cache"
        "~/.local/share"
        "/tmp"
        "/var/tmp"
        "~/Projects"
      ];
      root_dir = "${config.home.homeDirectory}/Sessions/";
    };
    settings.session_lens.load_on_setup = true;
    settings.session_lens.previewer = true;
    settings.session_lens.session_control.controlDir = "${config.home.homeDirectory}/Sessions/";
    settings.session_lens.session_control.controlFilename = "session_control.json";
    settings.cwd_change_handling = true;
  };

  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/Sessions/ 0755 felipemarcelino wheel - -"
  ];
}
