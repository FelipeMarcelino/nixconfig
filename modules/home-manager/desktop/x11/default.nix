{ pkgs, ... }:
{
  imports = [
    ./i3.nix
    ./autorandr.nix
    ./awesome
  ];
}
