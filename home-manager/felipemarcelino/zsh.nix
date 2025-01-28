{
  config,
  pkgs,
  ...
}:
{
  programs.zsh.sessionVariables = {
    GITHUB_ACCESS_TOKEN = ''$(${pkgs.coreutils}/bin/cat ${config.sops.secrets."github_token".path})'';
    ZK_NOTEBOOK_DIR = "${config.home.homeDirectory}/Zettelkasten/content";
  };

}
