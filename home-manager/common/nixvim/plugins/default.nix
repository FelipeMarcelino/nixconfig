{
  config,
  pkgs,
  ...
}: {
  imports = [ ./blink.nix ./cmp.nix];
}
