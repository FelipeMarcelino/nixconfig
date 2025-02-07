{ config, pkgs, ... }:
{

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
