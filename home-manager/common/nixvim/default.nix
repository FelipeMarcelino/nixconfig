{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./keymapping.nix
    ./options.nix
    ./plugins.nix
    ./plugins
    ./filetype.nix
    ./performance.nix
  ];

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

    colorschemes.onedark.enable = true;
  };
}
