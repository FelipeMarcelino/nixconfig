{
  config,
  pkgs,
  ...
}: {
  imports = [./blink.nix ./cmp.nix ./lsp.nix ./treesitter.nix ./trouble.nix];
}
