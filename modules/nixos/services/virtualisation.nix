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
      virtio-win
      win-spice
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          package = pkgs.qemu_kvm;
        };
      };
      spiceUSBRedirection.enable = true;
    };
    virtualisation.virtualbox.host.enableKvm = true;
    services.spice-vdagentd.enable = true;
  };
}
