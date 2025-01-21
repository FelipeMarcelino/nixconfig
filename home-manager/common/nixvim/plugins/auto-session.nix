{
  pkgs,
  config,
  ...
}:
{
  programs.nixvim.plugins.auto-session = {
    settings.log_level = "info";
    settings.auto_restore = true;
    settings.auto_save = true;
    settings = {
      enable_last_session = false;
      use_git_branch = true;
      create_enabled = true;
      suppress_dirs = [
        "~/.cache"
        "~/.local/share"
        "/tmp"
        "/var/tmp"
        "$XDG_PROJECTS_DIR"
        "$ZK_NOTEBOOK_DIR"
      ];
      root_dir = "$XDG_SESSIONS_DIR/";
      bypass_save_filetypes = [
        "alpha"
        "dashboard"
        "markdown"
        ".md"
      ];
    };
    settings.session_lens.load_on_setup = true;
    settings.session_lens.previewer = true;
    settings.session_lens.session_control.controlDir = "$XDG_SESSIONS_DIR/";
    settings.session_lens.session_control.controlFilename = "$XDG_SESSIONS_DIR/session_control.json";
    settings.cwd_change_handling = true;
  };

  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/Sessions/ 0755 ${config.home.username} wheel - -"
  ];
}
