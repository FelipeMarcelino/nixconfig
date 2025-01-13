{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.lsp.servers = {
    bashls.enable = true;
    lua_ls.enable = true;
    pylyzer.enable = true;
    zk.enable = true;
    nil_ls.enable = true;
  };
}
