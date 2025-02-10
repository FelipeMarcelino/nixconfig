{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.programs.gaming;
in
{
  options = {
    programs.gaming.enable = lib.mkEnableOption "Enable gamemode and steam";
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode.enable = true;
    programs.gamemode.enableRenice = true;
    programs.gamemode.settings = {
      general = {
        renice = 10;
        desiredgov = "performance";
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
      };
      custom = {
        start = "${pkgs.dunst}/bin/dunstify 'GameMode started'";
        end = "${pkgs.dunst}/bin/dunstify 'GameMode ended'";
      };
    };
    programs.steam.enable = true;
    programs.steam.extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    programs.steam.extraPackages = with pkgs; [
      gamescope
    ];

  };

}
