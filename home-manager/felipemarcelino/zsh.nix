{
  config,
  pkgs,
  ...
}:
{
  programs.zsh.sessionVariables = {
    #GITHUB_ACCESS_TOKEN = ''$(${pkgs.coreutils}/bin/cat ${config.sops.secrets."github_token".path})'';
    GITHUB_PERSONAL_ACCESS_TOKEN = ''$(${pkgs.coreutils}/bin/cat ${config.sops.secrets."GITHUB_PERSONAL_ACCESS_TOKEN".path})'';
    ZK_NOTEBOOK_DIR = "${config.home.homeDirectory}/Zettelkasten/content";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  programs.zsh.shellAliases = {
    reboot = "sudo /run/current-system/sw/bin/systemctl reboot";
  };

}
