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
    programs.steam.enable = true;
    programs.steam.extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    programs.steam.extraPackages = with pkgs; [
      gamescope
    ];

  };

}
