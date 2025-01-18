{
  config,
  pkgs,
  ...
}: {
  # Shows the breadcrumb lsp node path in lualine
  programs.nixvim.plugins.navic = {
    enable = true;

    settings = {
      lsp = {
        auto_attach = true;
      };
    };
  };
}
