{
  config,
  pkgs,
  ...
}: {
  imports = [./blink.nix ./cmp.nix ./lsp.nix];
}
