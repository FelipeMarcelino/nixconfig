{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.home.cli.git or {enable = false;};
in {
  options.home.cli.git = mkOption {
    description = "Enable eza substitute of ls";
    type = types.attrs;
    default = {enable = false;};
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      delta = {
        enable = true;
        options = {
          features = "side-by-side line-numbers decorations";
          delta = {
            navigate = true;
          };
        };
      };

      aliases = {
        branch-default = ''!git symbolic-ref --short refs/remotes/origin/HEAD | sed "s|^origin/||"'';
        checkout-default = ''!git checkout "$(git branch-default)"'';
        rebase-default = ''!git rebase "$(git branch-default)"'';
        merge-default = ''!git merge "$(git branch-default)"'';
        branch-cleanup = ''!git branch --merged | egrep -v "(^\*|master|main|dev|development)" | xargs git branch -d #'';
        # Restores the commit message from a failed commit for some reason
        fix-commit = ''!git commit -F "$(git rev-parse --git-dir)/COMMIT_EDITMSG" --edit'';
        pushf = "push --force-with-lease";
        logs = "log --show-signature";
      };

      ignores = [
        "*.swp"
        "*~"
        ".dir-locals.el"
        ".DS_Store"
        ".lsp"
        ".projectile"
        "Thumbs.db"
      ];

      includes = [{path = "~/.config/git/local";}];

      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        branch = {
          sort = "-committerdate";
        };
        color = {
          ui = true;
        };
        commit = {
          verbose = true;
        };
        core = {
          editor = "nvim";
          whitespace = "trailing-space,space-before-tab,indent-with-non-tab";
        };
        checkout = {
          defaultRemote = "origin";
        };
        github = {
          user = "FelipeMarcelino";
        };
        merge = {
          conflictstyle = "zdiff3";
          tool = "nvim -d";
        };
        pull = {
          rebase = true;
        };
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
        rebase = {
          autoStash = true;
        };
        tag.sort = "-version:refname";
      };
    };
  };
}
