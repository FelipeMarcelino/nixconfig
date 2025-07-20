{
  pkgs,
  config,
  ...
}: {
  programs.neovim.extraConfig = ''
    set guifont=PragmataPro_Nerd_Font_Mono:h10
  '';
}
