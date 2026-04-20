{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        nil_ls = {
          settings = {
            formatting = {
              command = ["${lib.getExe pkgs.nixfmt}"];
            };
            nix = {
              flake = {
                autoArchive = true;
              };
            };
          };
        };
      };
    };
  };
}
