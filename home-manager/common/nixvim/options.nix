{ config, pkgs, ...}:
{
   programs.nixvim.opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 4;
    autoread = true;
   };

}
