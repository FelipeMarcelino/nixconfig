{
  config,
  pkgs,
  lib,
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
      XDG_TASKWARRIOR_DIR = "${config.home.homeDirectory}/Taskwarrior";
    };
  };

  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "zathura.desktop" ];
    "image/jpeg" = [ "mpv.desktop" ];
    "image/jpg" = [ "mpv.desktop" ];
    "image/png" = [ "mpv.desktop" ];
  };

  xdg.mimeApps.associations.added = {
    "application/pdf" = [ "zathura.desktop" ];
    "image/jpeg" = [ "mpv.desktop" ];
    "image/jpg" = [ "mpv.desktop" ];
    "image/png" = [ "mpv.desktop" ];
  };

  xdg = {
    desktopEntries."zathura" = {
      name = "zathura";
      type = "Application";
      icon = "zathura";
      comment = "A minimalistic PDF viewer";
      categories = [
        "Office"
        "Viewer"
      ];
      exec = "zathura --fork %f";
      terminal = false;
      mimeType = [ "application/pdf" ];
    };
  };

}
