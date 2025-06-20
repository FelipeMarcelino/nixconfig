{ config, pkgs, ... }:
{
  programs.nixvim.plugins.zk = {
    settings = {
      lsp = {
        auto_attach = {
          enabled = true;
          filetypes = [
            "markdown"
            "vimwiki"
            "wiki"
          ];
        };
        config = {
          cmd = [
            "zk"
            "lsp"
          ];
          name = "zk";
          filetypes = [
            "markdown"
            "vimwiki"
            "wiki"
          ];
        };
      };
      picker = "telescope";
    };
  };
}
