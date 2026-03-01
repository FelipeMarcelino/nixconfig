# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/default.nix
    ./greetd.nix
    ./security.nix
    inputs.sops-nix.nixosModules.sops
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "solid"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    # Automatically prefer ethernet over wifi when both are connected
    insertNameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
    dns = "systemd-resolved";
    # Enable connectivity checking
    settings = {
      connectivity = {
        uri = "http://connectivitycheck.gstatic.com/generate_204";
        interval = 30;
        response = "";
      };
    };
  };

  # Configure interface priorities and connectivity management
  networking.networkmanager.dispatcherScripts = [
    {
      source = pkgs.writeScript "10-manage-connectivity" ''
        #!/bin/sh
        # Auto-disable ethernet when it has no internet connectivity

        # Set PATH to ensure commands are available
        PATH=/run/current-system/sw/bin:/run/wrappers/bin:$PATH

        check_connectivity() {
          # Test connectivity using ping only (more reliable in dispatcher context)
          ping -c 1 -W 3 8.8.8.8 > /dev/null 2>&1
        }

        # Log all dispatcher events for debugging
        logger "NetworkManager dispatcher: interface=$1 action=$2 connection_id=$CONNECTION_ID"

        if [ "$2" = "up" ] && [ -n "$CONNECTION_ID" ]; then
          # When interface comes up and CONNECTION_ID is available
          if echo "$1" | grep -E '^(enp|eth)' > /dev/null; then
            # Ethernet interface
            sleep 5  # Wait for connection to stabilize
            if ! check_connectivity; then
              # No internet via ethernet, disable it
              nmcli connection down "$CONNECTION_ID"
              logger "NetworkManager: Disabled ethernet $1 ($CONNECTION_ID) due to no internet connectivity"
            else
              # Set low metric for ethernet (high priority)
              nmcli connection modify "$CONNECTION_ID" ipv4.route-metric 100
              logger "NetworkManager: Ethernet $1 ($CONNECTION_ID) has connectivity, setting high priority"
            fi
          elif echo "$1" | grep -E '^(wl|wifi)' > /dev/null; then
            # WiFi interface - set high metric (low priority)
            nmcli connection modify "$CONNECTION_ID" ipv4.route-metric 200
            logger "NetworkManager: WiFi $1 ($CONNECTION_ID) set to low priority"
          fi
        fi
      '';
      type = "basic";
    }
  ];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    # powerOnBoot = true;
    # settings = {
    #   General = {
    #     ControllerMode = "bredr";
    #     FastConnectable = true; # increased power consumption
    #     Experimental = true;
    #     DiscoverableTimeout = "0";
    #     KernelExperimental = true;
    #   };
    #   Policy = {
    #     AutoEnable = "true";
    #   };
    # };
  };

  # hardware.pulseaudio.configFile = pkgs.writeText "default.pa" ''
  #   load-module module-bluetooth-policy
  #   load-module module-bluetooth-discover
  #   ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
  #   # load-module module-bluez5-device
  #   # load-module module-bluez5-discover
  # '';

  # Enable the X11 wxSessio3nindowing system.
  services.xserver.enable = true;
  #services.displayManager.sessionPackages = [ pkgs.i3. ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = false;
    wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
  #services.greetd.enable = true;
  #programs.regreet.enable = true;

  # I3
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.startx.enable = true;

  # Ly
  #services.displayManager.ly.enable = true;

  # Awesome
  services.xserver.windowManager.awesome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    i3
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    gparted
    toybox
    beauty-line-icon-theme
    dconf-editor
    vulkan-tools
  ];
  hardware.graphics.enable32Bit = true;
  #hardware.graphics.extraPackages = with pkgs; [ vulkan-tools ];
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  sops = {
    age.keyFile = "/home/felipemarcelino/.config/sops/age/keys.txt";
    defaultSopsFile = ./../../secrets/felipemarcelino.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      password_hash = {
        mode = "0400";
        #neededForUsers = true;
      };
    };
  };

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.zsh.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  security.polkit.enable = true;

  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
  gtk.iconCache.enable = true;
  qt.platformTheme.name = "gtk3";
  qt.style.name = "gtk3";

  # Thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.tumbler
    ffmpegthumbnailer
    poppler_gi
    gnome-epub-thumbnailer
  ];

  services.gvfs.enable = lib.mkForce false;

  programs.dconf.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0032", ATTR{authorized}="0"
  '';

  virtualisation.docker.enable = true;

  services.dbus = {
    enable = true;
    # Expose system-wide services (e.g., NetworkManager, UPower)
    packages = [ pkgs.dconf ];
  };

  services.acpid = {
    enable = true;
    handlers = {
      # Block Fn+Esc (power button) from triggering shutdown
      ignore-power = {
        event = "button/power.*"; # Matches the event from acpi_listen
        action = ""; # Empty action to ignore the event
      };
    };
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
