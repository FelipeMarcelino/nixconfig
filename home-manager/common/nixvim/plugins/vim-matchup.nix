{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.vim-matchup.settings = {
    surround_enabled = 1;
    transmute_enabled = 1;
  };
}
