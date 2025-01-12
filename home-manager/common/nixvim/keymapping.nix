{config, pkgs, ...}:
{
    programs.nixvim.globals.mapleader = " ";
    programs.nixvim.keymaps = [
    {
	key = ";";
	action = ":";
    }

    ];
}
