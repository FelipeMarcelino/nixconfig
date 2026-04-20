{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    illuminate = {
      # TODO: migrate to mkNeovimPlugin
      # lazyLoad.settings.event = "DeferredUIEnter";

      filetypesDenylist = [
        "dirvish"
        "fugitive"
        "neo-tree"
        "TelescopePrompt"
      ];
      settings.large_file_cutoff = 3000;
    };
  };
}
