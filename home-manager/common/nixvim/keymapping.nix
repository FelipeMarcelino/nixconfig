{config, pkgs, ...}:
{
    programs.nixvim.globals.mapleader = " ";
    keymaps = [
    {
	key = ";";
	action = ":";
    }
    ];
}
