{ config, pkgs, ... }:
{
  programs.nixvim.plugins.smartcolumn = {
    enable = true;

    lazyLoad.settings.event = "BufEnter";

    settings = {
      colorcolumn = "100";
      disabled_filetypes = [
        "ministarter"
        "checkhealth"
        "help"
        "lspinfo"
        "markdown"
        "neo-tree"
        "noice"
        "text"
      ];
      custom_colorcolumn = {
        go = [
          "100"
          "130"
        ];
        java = [
          "100"
          "140"
        ];
        nix = [
          "100"
          "120"
        ];
        rust = [
          "100"
          "120"
        ];

        python = [
          "100"
          "120"
        ];
      };
      scope = "file";
    };
  };
}
