# OpenClaw AI assistant gateway (via nix-openclaw)
{ inputs, pkgs, ... }:
{
  programs.openclaw = {
    enable = true;

    # Use the batteries-included package built against nix-openclaw's own
    # pinned nixpkgs. The overlay package builds against our nixpkgs, whose
    # nodejs_22 (22.22.0) is too old for the gateway (needs >=22.22.3).
    instances.default.package =
      inputs.nix-openclaw.packages.${pkgs.stdenv.hostPlatform.system}.openclaw;

    # Secret files materialized outside the Nix store; read at service start.
    environment = {
      OPENCLAW_GATEWAY_TOKEN = "/home/felipemarcelino/.secrets/openclaw-gateway-token";
      OPENCODE_API_KEY = "/home/felipemarcelino/.secrets/opencode-api-key";
      OPENCODE_ZEN_API_KEY = "/home/felipemarcelino/.secrets/opencode-api-key";
    };

    # Nix-managed workspace bootstrap files (content lives in
    # ~/code/openclaw-local/workspace, deployed to ~/.openclaw/workspace).
    workspace.bootstrapFiles = {
      agents = /home/felipemarcelino/code/openclaw-local/workspace/AGENTS.md;
      soul = /home/felipemarcelino/code/openclaw-local/workspace/SOUL.md;
      tools = /home/felipemarcelino/code/openclaw-local/workspace/TOOLS.md;
      identity = /home/felipemarcelino/code/openclaw-local/workspace/IDENTITY.md;
      user = /home/felipemarcelino/code/openclaw-local/workspace/USER.md;
    };

    config = {
      gateway = {
        mode = "local";
        auth.token = {
          source = "env";
          provider = "default";
          id = "OPENCLAW_GATEWAY_TOKEN";
        };
      };

      agents.defaults.model.primary = "opencode-go/deepseek-v4-pro";
      memory.backend = "qmd";

      plugins.entries = {
        "document-extract".enabled = true;
        "active-memory".enabled = true;
        senseaudio.enabled = true;
        "web-readability".enabled = true;
      };

      channels.telegram = {
        enabled = true;
        tokenFile = "/home/felipemarcelino/.secrets/telegram-bot-token";
        allowFrom = [ 625724324 ];
        groups."*".requireMention = true;
      };
    };
  };
}
