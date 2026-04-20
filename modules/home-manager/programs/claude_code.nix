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
        command = "${pkgs.writeShellScript "github-mcp-wrapper" ''
          export GITHUB_PERSONAL_ACCESS_TOKEN="$(${pkgs.coreutils}/bin/cat ${config.sops.secrets."GITHUB_PERSONAL_ACCESS_TOKEN".path})"
          exec ${pkgs.nodejs}/bin/npx -y @modelcontextprotocol/server-github
        ''}";
        env = {
          PATH = "${pkgs.nodejs}/bin:${pkgs.bash}/bin:${pkgs.coreutils}/bin";
        };
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
      serena = {
        command = "${pkgs.uv}/bin/uvx";
        args = [
          "--from"
          "git+https://github.com/oraios/serena"
          "serena"
          "start-mcp-server"
        ];
      };
      codecov = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [
          "-y"
          "@egulatee/mcp-codecov"
        ];
        env = {
          PATH = "${pkgs.nodejs}/bin:${pkgs.bash}/bin:${pkgs.coreutils}/bin";
          CODECOV_BASE_URL = "https://codecov.io";
          CODECOV_TOKEN = "682acb66-3397-4612-9165-9bcb00560e04";
        };
      };
    };
  };
}
