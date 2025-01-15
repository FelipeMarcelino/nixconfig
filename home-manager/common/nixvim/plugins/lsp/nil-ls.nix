{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        nil_ls = {
          settings = {
            formatting = {
              command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
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
