{
  config,
  pkgs,
  ...
}: {
  imports = [./auto-save.nix ./auto-session.nix ./blink.nix ./better-escape.nix ./cmp.nix ./conform.nix ./copilot.nix ./lsp.nix ./treesitter.nix ./trouble.nix];
}
