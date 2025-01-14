{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.vim-matchup = {
    surround_enabled = 1;
    transmute_enabled = 1;
  };
}
