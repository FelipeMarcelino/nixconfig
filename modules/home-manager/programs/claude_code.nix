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
      railway-mcp-server = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [
          "-y"
          "@railway/mcp-server"
        ];
        env = {
          PATH = "${pkgs.nodejs}/bin:${pkgs.bash}/bin:${pkgs.coreutils}/bin";
        };
      };
      context7 = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [
          "-y"
          "@upstash/context7-mcp"
          "--api-key"
          "ctx7sk-1186aee0-896e-4ad8-9ab5-0a9a8b181ca2"
        ];
        env = {
          PATH = "${pkgs.nodejs}/bin:${pkgs.bash}/bin:${pkgs.coreutils}/bin";
        };
      };
    };
  };
}
