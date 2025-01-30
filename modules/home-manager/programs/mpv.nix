{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.home.programs.mpv or { enable = false; };
in
{

  options.home.programs.mpv = mkOption {
    description = "Enable mpv player";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.mpv.enable = true;
    programs.mpv.config = {
      profile = "high-quality";
      vo = "gpu";
      gpu-api = "vulkan";
      fullscreen = "yes";
      force-seekable = "yes";
      keep-open = "always";
      reset-on-next-file = "pause";
      hwdec = "nvdec";
      dscale = "mitchell";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossoft";
      glsl-shader = "${pkgs.pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders/FSRCNNX_x2_16-0-4-1.glsl";
      deband = "no";
      deband-iterations = 2;
      deband-threshold = 64;
      deband-range = 17;
      deband-grain = 12;
      osd-bar = "no";
      osc = "no";
      border = "no";
      cursor-autohide-fs-only = "yes";
      cursor-autohide = 300;
      osd-level = 1;
      osd-duration = 1000;
      hr-seek = "yes";
      osd-font = "Verdana";
      osd-font-size = 20;
      osd-color = "#FFFFFF";
      osd-border-color = "#000000";
      osd-border-size = 0.6;
      osd-blur = 0.2;
      alang = "ja,jp,jpn,en,eng,ptBr"; # Audio language priority
      slang = "en,eng,ptBr"; # Subtitle language priority
      volume = 100;
      audio-file-auto = "fuzzy";
      volume-max = 200;
      audio-pitch-correction = "yes";
      demuxer-mkv-subtitle-preroll = "yes";
      #sub-ass-vsfilter-blur-compat = "no";
      sub-ass-use-video-data = "all";
      sub-fix-timing = "no";
      sub-auto = "fuzzy";
      sub-font = "Netflix Sans Medium";
      sub-font-size = 40;
      sub-color = "#FFFFFFFF";
      sub-border-color = "#FF000000";
      sub-border-size = 2.0;
      sub-shadow-offset = 0;
      sub-spacing = 0.0;
      screenshot-format = "png";
      screenshot-high-bit-depth = "yes";
      screenshot-png-compression = 1;
      screenshot-directory = "~/Pictures/screenshots";
      screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";
    };
    programs.mpv.profiles = {
      "HDR" = {
        profile-desc = "Tone mapping using reinhard";
        profile-restore = "copy-equal";
        tone-mapping = "reinhard";
        tone-mapping-param = 0.6;
        hdr-compute-peak = "no";
        blend-subtitles = "video";
      };
      "WEB-DL" = {
        profile-desc = "WEB-DL Anime (HatSubs, SubsPlease, HorribleSubs, Erai-raws)";
        profile-cond = ''string.match(p.filename, "HatSubs") or string.match(p.filename, "SubsPlease") or string.match(p.filename, "HorribleSubs") or string.match(p.filename, "Erai%%-raws")'';

        deband = "yes";
      };

    };
    programs.mpv.scriptOpts = {
      gif = {
        rez = 1920;
        fps = 23.976;
        dir = "";
      };
      osc = {
        scalewindowed = 0.8;
        scalefullscreen = 0.8;
        hidetimeout = 300;
        showonpouse = "no";
      };
      thumbfast = {
        max_height = 250;
        max_width = 250;
        spawn_first = "yes";
        network = "yes";
        hwdec = "yes";
      };
    };
    programs.mpv.scripts = with pkgs.mpvScripts; [
      autoload
      modernx-zydezu
      mpris
      thumbfast
      sponsorblock
      mpv-playlistmanager
      occivink.seekTo
      visualizer
      occivink.blacklistExtensions
    ];

    programs.mpv.bindings = {
      MBTN_LEFT_DBL = "cycle fullscreen ";
      MBTN_RIGHT = "cycle fullscreen";
      MBTN_BACK = "playlist-prev";
      MBTN_FORWARD = "playlist-next";
      WHEEL_UP = "seek 10";
      WHEEL_DOWN = "seek -10";
      WHEEL_LEFT = "add volume -2";
      WHEEL_RIGHT = "add volume 2";
      RIGHT = "seek  5";
      LEFT = "seek -5";
      UP = "seek  60";
      DOWN = "seek -60";
      "Shift+RIGHT" = "no-osd seek  1 exact";
      "Shift+LEFT" = "no-osd seek -1 exact";
      "Shift+UP" = "no-osd seek  5 exact";
      "Shift+DOWN" = "no-osd seek -5 exact";
      "Ctrl+LEFT" = "no-osd sub-seek -1";
      "Ctrl+RIGHT" = "no-osd sub-seek  1";
      "Ctrl+Shift+LEFT" = "sub-step -1";
      "Ctrl+Shift+RIGHT" = "sub-step 1";
      "Alt+left" = "add video-pan-x  0.1";
      "Alt+right" = "add video-pan-x -0.1";
      "Alt+up" = "add video-pan-y  0.1";
      "Alt+down" = "add video-pan-y -0.1";
      "Alt++" = "add video-zoom   0.1";
      "Alt+-" = "add video-zoom  -0.1";
      "Alt+BS" = "set video-zoom 0 ; set video-pan-x 0 ; set video-pan-y 0";
      "PGUP" = "add chapter 1";
      "PGDWN" = "add chapter -1";
      "Shift+PGUP" = "seek 600";
      "Shift+PGDWN" = "seek -600";
      "[" = "multiply speed 1/1.1";
      "]" = "multiply speed 1.1";
      "{" = "multiply speed 0.5";
      "}" = "multiply speed 2.0";
      "BS" = "set speed 1.0";
      "Shift+BS" = "revert-seek";
      "Shift+Ctrl+BS" = "revert-seek mark";
      "q" = "quit";
      "Q" = "quit-watch-later";
      "ESC" = "set fullscreen no";
      "p" = "cycle pause";
      "." = "frame-step";
      "," = "frame-back-step";
      "SPACE" = "cycle pause";
      ">" = "playlist-next";
      "ENTER" = "playlist-next";
      "<" = "playlist-prev";
      "O" = "no-osd cycle-values osd-level 3 1";
      "o" = "show-progress";
      "P" = "show-progress";
      "i" = "script-binding stats/display-stats";
      "I" = "script-binding stats/display-stats-toggle";
      "`" = "script-binding console/enable";
      "z" = "add sub-delay -0.1";
      "Z" = "add sub-delay +0.1";
      "ctrl++" = "add audio-delay 0.100";
      "ctrl+-" = "add audio-delay -0.100";
      "Shift+g" = "add sub-scale +0.1";
      "Shift+f" = "add sub-scale -0.1";
      "9" = "add volume -2";
      "/" = "add volume -2";
      "0" = "add volume 2";
      "*" = "add volume 2";
      "m" = "cycle mute";
      "1" = "add contrast -1";
      "2" = "add contrast 1";
      "3" = "add brightness -1";
      "4" = "add brightness 1";
      "5" = "add gamma -1";
      "6" = "add gamma 1";
      "7" = "add saturation -1";
      "8" = "add saturation 1";
      "Alt+0" = "set current-window-scale 0.5";
      "Alt+1" = "set current-window-scale 1.0";
      "Alt+2" = "set current-window-scale 2.0";
      "r" = "add sub-pos -1";
      "R" = "add sub-pos +1";
      "t" = "add sub-pos +1";
      "v" = "cycle sub-visibility";
      "Alt+v" = "cycle secondary-sub-visibility";
      "V" = "cycle sub-ass-vsfilter-aspect-compat";
      "u" = ''cycle-values sub-ass-override "force" "no"'';
      "j" = "cycle sub";
      "J" = "cycle sub down";
      "_" = "cycle video";
      "T" = "cycle ontop";
      "f" = "cycle fullscreen";
      "s" = "screenshot";
      "S" = "screenshot video";
      "Ctrl+s" = "screenshot window";
      "Alt+s" = "screenshot each-frame";
      "w" = "add panscan -0.1";
      "W" = "add panscan +0.1";
      "e" = "add panscan +0.1";
      "ctrl+w" = "quit";
      "E" = "cycle edition";
      "l" = "ab-loop";
      "L" = ''cycle-values loop-file "inf" "no"'';
      "ctrl+c" = "quit 4";
      "DEL" = "script-binding osc/visibility";
      "ctrl+h" = ''cycle-values hwdec "auto" "no"'';
      "F8" = "show-text \${playlist}";
      "F9" = "show-text \${track-list}";
      "d" = "cycle deband";
      "D" = "cycle deinterlace";
      "n" = "cycle video-unscaled";
      "C" = ''cycle-values video-aspect-override "16:9" "4:3" "2.35:1" "-1"'';
      "a" = "cycle audio";
      "A" = "cycle audio down";
      "x" = "add audio-delay -0.05";
      "X" = "add audio-delay +0.05";
      "~" =
        ''script-message cycle-commands "apply-profile HDR ; show-text 'HDR profile applied'" "apply-profile HDR restore ; show-text 'HDR profile restored'"'';
      "ctrl+S" = "script-binding toggle-seeker";
      "alt+b" = "script-binding sponsorblock";

    };

  };

}
