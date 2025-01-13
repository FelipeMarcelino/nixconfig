{
  config,
  pkgs,
  ...
}: {
  imports = [./auto-save.nix ./auto-session.nix ./blink.nix ./better-escape.nix ./cmp.nix ./lsp.nix ./treesitter.nix ./trouble.nix];
}
