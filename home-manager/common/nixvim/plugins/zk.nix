{ config, pkgs, ... }:
{
  programs.nixvim.plugins.zk = {
    settings = {
      lsp = {
        auto_attach = {
          enabled = true;
          filetypes = [
            "markdown"
          ];
        };
        config = {
          cmd = [
            "zk"
            "lsp"
          ];
          name = "zk";
        };
      };
      picker = "telescope";
    };
  };
}
