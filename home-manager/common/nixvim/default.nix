{ config , pkgs, ...}:
{
   imports = [ ./keymapping.nix ./options.nix ];

   home.packages = with pkgs; [ xclip ];

   programs.nixvim = {
   	enable = true;
	viAlias = true;
	vimAlias = true;

	clipboard = {
	    register = "unnamedplus";
	    providers.xclip.enable = true;
	};

	diagnostics = {
	    virtual_text = false;
	};

	colorscheme = "onedark";

	opts = {
	    number = true;
	    relativenumber = true;
	    shiftwidth = 4;
	};

   };
}

