{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.claude or { enable = false; };
in
{
  options.home.programs.claude = mkOption {
    description = "Enable claude code";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.claude-code.enable = true;
    programs.claude-code.mcpServers = {
      github = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-github"
        ];
        env = {
          PATH = "${pkgs.nodejs}/bin:${pkgs.bash}/bin:${pkgs.coreutils}/bin";
        };
        # GITHUB_PERSONAL_ACCESS_TOKEN is exported from sops in zsh.nix
      };
    };
  };
}
