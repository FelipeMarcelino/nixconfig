# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here

  home = {
    username = "felipemarcelino";
    homeDirectory = "/home/${config.home.username}";
  };

  # Install firefox.
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    pragmata-monolisa-fonts
    element-desktop
    discord
    beauty-line-icon-theme
    mpv-custom-fonts
    telegram-desktop
    teams-for-linux
    chromium
    zoom-us
    anki-bin
    gemini-cli
  ];

  imports = [
    ./zsh.nix
    ./xdg.nix
  ];

  # walppapers
  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/.wallpappers/ 0755 felipemarcelino wheel - -"
  ];
  home.file."${config.home.homeDirectory}/.wallpappers/vertical.png".source =
    ../../wallpapers/solid/monitor_vertical/forrest.png;
  home.file."${config.home.homeDirectory}/.wallpappers/horizontal.jpg".source =
    ../../wallpapers/solid/monitor_horizontal/shaded_landscape.jpg;

  # My modules
  home = {

    desktop = {
      swayi3.enable = false; # wayland is broken when using nvidia proprietary driver -- waiting for 555v
      i3.enable = true;
      autorandr.enable = true;
    };

    terminal.ghostty.enable = true;

    programs = {
      rofi.enable = true;
      yt-dlp.enable = true;

    };

    services = {
      polybar.enable = true;
      dunst.enable = true;
      udiskie.enable = true;
      screen-locker-x.enable = true;
      picom.enable = true;
    };

    cli = {
      aws.enable = true;
      azure.enable = true;
    };
  };

  # syncthing
  home.file."${config.home.homeDirectory}/.local/state/syncthing/cert.pem".source =
    ./syncthing/cert.pem;
  home.file."${config.home.homeDirectory}/.local/state/syncthing/key.pem".source =
    ./syncthing/key.pem;
  home.file."${config.home.homeDirectory}/.local/state/syncthing/config.xml".source =
    ./syncthing/config.xml;

  # GTK
  gtk = {
    enable = true;
    font.name = "PragmataProMono Nerd Font";
    font.size = 12;
    iconTheme.package = pkgs.beauty-line-icon-theme;
    iconTheme.name = "BeautyLine";
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };
  qt.platformTheme.name = "gtk3";
  qt.style.name = "gtk3";

  catppuccin = {
    gtk = {
      enable = true;
      flavor = "macchiato";
      accent = "pink";
      size = "standard";
      tweaks = [ "normal" ];
    };
    starship.enable = true;
    spotify-player = {
      enable = true;
      flavor = "macchiato";
    };
    bat = {
      enable = true;
      flavor = "macchiato";
    };
    delta = {
      enable = true;
      flavor = "macchiato";
    };
    fzf = {
      enable = true;
      flavor = "macchiato";
    };
    mpv = {
      enable = true;
      flavor = "macchiato";
    };
    yazi = {
      enable = true;
      flavor = "macchiato";
    };
  };

  home.pointerCursor = {
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
    size = 24;
  };

  home.programs.mpv.enable = true;

  services.pasystray.enable = true;

  # Git
  programs.git.userEmail = "felipe.marcelino1991@gmail.com";
  programs.git.userName = "Felipe Marcelino";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
