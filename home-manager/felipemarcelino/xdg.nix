{ config, pkgs, ... }:
{
  # Browser padrão para terminal
  home.sessionVariables = {
    BROWSER = "firefox-beta";
  };

  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "zathura.desktop" ];
    "image/jpeg" = [ "mpv.desktop" ];
    "image/jpg" = [ "mpv.desktop" ];
    "image/png" = [ "mpv.desktop" ];
    # Browser
    "text/html" = [ "firefox-beta.desktop" ];
    "x-scheme-handler/http" = [ "firefox-beta.desktop" ];
    "x-scheme-handler/https" = [ "firefox-beta.desktop" ];
    "x-scheme-handler/about" = [ "firefox-beta.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox-beta.desktop" ];
    "application/xhtml+xml" = [ "firefox-beta.desktop" ];
    "application/x-extension-htm" = [ "firefox-beta.desktop" ];
    "application/x-extension-html" = [ "firefox-beta.desktop" ];
    "application/x-extension-shtml" = [ "firefox-beta.desktop" ];
    "application/x-extension-xhtml" = [ "firefox-beta.desktop" ];
    "application/x-extension-xht" = [ "firefox-beta.desktop" ];
  };

  xdg.mimeApps.associations.added = {
    "application/pdf" = [ "zathura.desktop" ];
    "image/jpeg" = [ "mpv.desktop" ];
    "image/jpg" = [ "mpv.desktop" ];
    "image/png" = [ "mpv.desktop" ];
    # Browser
    "text/html" = [ "firefox-beta.desktop" ];
    "x-scheme-handler/http" = [ "firefox-beta.desktop" ];
    "x-scheme-handler/https" = [ "firefox-beta.desktop" ];
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
