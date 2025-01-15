{
  config,
  pkgs,
  ...
}:
{
  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs = {
    extraConfig = {
      XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      XDG_SESSIONS_DIR = "${config.home.homeDirectory}/Sessions";
      XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
    };
  };

}
