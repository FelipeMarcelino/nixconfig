{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.yt-dlp or { enable = false; };
in
{
  options.home.programs.yt-dlp = mkOption {
    description = "Enable youtube downloader";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.yt-dlp = {
      enable = true;
      settings = {

        ignore-errors = true;
        no-abort-on-error = true;
        embed-subs = true;
        embed-metadada = true;
        format-sort = "ext";
        yes-playlist = true;
        playlist-reverse = true;
        paths = "${config.xdg.userDirs.extraConfig.XDG_YT_DLP_DIR}";
        download-archive = "";
        output = "%(id)s_views_%(view_count)d_likes_%(like_count)d_rating_%(average_rating)d_[%(fulltitle)s_%(*USERNAME*)s_%(webpage_url_domain)s].%(ext)s";
        restrict-filenames = true;
        trim-filenames = 200;
        force-write-archive = true;
        cookies-from-browser = "Firefox";
        progress = true;
        sub-langs = "en.*,pt-br.*";
        embed-thumbnail = true;
        convert-thumbnails = "png";
      };
    };
  };
}
