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

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    diagnostics = {
      virtual_text = false;
    };

    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings = {
      flavour = "mocha";
    };

    extraPython3Packages = python-pkgs: [
      python-pkgs.numpy
      python-pkgs.pandas
      python-pkgs.scipy
      python-pkgs.matplotlib
      python-pkgs.requests
    ];
  };
}
