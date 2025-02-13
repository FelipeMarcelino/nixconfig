{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.services.virtualisation;
in
{

  options = {
    services.virtualisation.enable = lib.mkEnableOption "Enable virtual machine";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      gnome.adwaita-icon-theme
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
