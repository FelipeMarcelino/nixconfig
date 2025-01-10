{ config , pkgs, ...}:
{
   imports = [ ./keymappings.nix ];

   programs.nixvim = {
   	enable = true;

   };
}

