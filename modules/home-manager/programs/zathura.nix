{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.programs.zathura or { enable = false; };
in
{
  options.home.programs.zathura = mkOption {
    description = "Enable zathura pdf reader";
    type = types.attrs;
    default = {
      enable = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      extraConfig = ''
        set recolor
        set statusbar-h-padding 0
        set statusbar-v-padding 0
        set page-padding 1
        set selection-clipboard clipboard
        map i recolor
        set font                        "PragmataProMono Nerd Font"
        set default-fg                rgba(202,211,245,1)
        set default-bg 			          rgba(36,39,58,1)

        set completion-bg		          rgba(54,58,79,1)
        set completion-fg		          rgba(202,211,245,1)
        set completion-highlight-bg	  rgba(87,82,104,1)
        set completion-highlight-fg	  rgba(202,211,245,1)
        set completion-group-bg		    rgba(54,58,79,1)
        set completion-group-fg		    rgba(138,173,244,1)

        set statusbar-fg		          rgba(202,211,245,1)
        set statusbar-bg		          rgba(54,58,79,1)

        set notification-bg		        rgba(54,58,79,1)
        set notification-fg		        rgba(202,211,245,1)
        set notification-error-bg	    rgba(54,58,79,1)
        set notification-error-fg	    rgba(237,135,150,1)
        set notification-warning-bg	  rgba(54,58,79,1)
        set notification-warning-fg	  rgba(250,227,176,1)

        set inputbar-fg			          rgba(202,211,245,1)
        set inputbar-bg 		          rgba(54,58,79,1)

        set recolor                   "true"
        set recolor-lightcolor		    rgba(36,39,58,1)
        set recolor-darkcolor		      rgba(202,211,245,1)

        set index-fg			            rgba(202,211,245,1)
        set index-bg			            rgba(36,39,58,1)
        set index-active-fg		        rgba(202,211,245,1)
        set index-active-bg		        rgba(54,58,79,1)

        set render-loading-bg		      rgba(36,39,58,1)
        set render-loading-fg		      rgba(202,211,245,1)

        set highlight-color		        rgba(87,82,104,0.5)
        set highlight-fg              rgba(245,189,230,0.5)
        set highlight-active-color	  rgba(245,189,230,0.5)
      '';
    };
  };
}
