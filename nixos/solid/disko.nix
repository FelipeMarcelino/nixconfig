{
  lib,
  disks ? [
    "/dev/sda"
    "/dev/nvme0n1"
    "/dev/nvme1n1"
  ],
  ...
}:

{
  disko.devices = {
    disk = {
      # Main system disk
      sda = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "4G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "123G";
              content = {
                type = "luks";
                name = "crypted-root";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
            home = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted-home";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/home";
                };
              };
            };
          };
        };
      };

      # Games NVME
      disk.nvme0 = {
        type = "disk";
        device = builtins.elemAt disks 1;
        content = {
          type = "gpt";
          partitions = {
            swap = {
              size = "64G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            games = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home/felipemarcelino/Games";
              };
            };
          };
        };
      };

      # Data NVME
      nvme1 = {
        type = "disk";
        device = builtins.elemAt disks 2;
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home/felipemarcelino/Data";
              };
            };
          };
        };
      };
    };

    # Special configuration for /nix/store
    nodev = {
      "/nix/store" = {
        fsType = "none";
        mountOptions = [
          "bind"
          "/nix/.ro-store"
        ];
      };
    };
  };
}
