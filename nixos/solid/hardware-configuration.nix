# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "thunderbolt"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "bluetooth"
    "btusb"
    "btintel"
    "btrtl"
    "btbcm"
    "btmtk"
    # Required for BAP/ISO
    "bluetooth_iso"
    "bt_iso"
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/2a7dd5a9-3ae7-4d09-bf64-7c8f8e2c43cf";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."crypt-root".device = "/dev/disk/by-uuid/99913f4a-4040-4f4d-a370-7d9b1e09da87";

  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/e06f5bac-99ee-4040-b62c-3e58e23b7e77";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8DDC-299F";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/c391a647-a735-4075-8243-7c9235ac3e6b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."crypt-home".device = "/dev/disk/by-uuid/164e4395-74c1-4383-8d2a-dd3cbfec0e63";

  swapDevices =
    [ { device = "/dev/disk/by-uuid/405b2523-63f3-4082-b672-fb58da107baa"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
