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
      osd-bar = "no";
      osc = "no";
      border = "no";
      cursor-autohide-fs-only = "yes";
      cursor-autohide = 300;
      osd-level = 1;
      osd-duration = 1000;
      hr-seek = "yes";
      osd-font = kk;
      osd-font-size = 20;
      osd-color = "#FFFFFF";
      osd-border-color = "#000000";
      osd-border-size = 0.6;
      osd-blur = 0.2;
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
      sub-ass-vsfilter-blur-compat = "no";
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
  };

}
