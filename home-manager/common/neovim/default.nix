{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = false;
    viAlias = true;
    vimAlias = true;
    vimDiffAlias = true;
    defaultEditor = true;
  };

  imports = [./core.nix];
}
