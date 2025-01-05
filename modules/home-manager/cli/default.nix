{ pkgs, ...}: 
{

  imports = [ ./eza.nix ./zoxide.nix ./bat.nix ./fzf.nix ];





  programs.starship.enable = true;



}
