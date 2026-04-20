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
    codex
    gh
    cookiecutter
    insync
    foliate
    spotdl
    android-tools
    opencode
  ];

  imports = [
    ./zsh.nix
    ./xdg.nix
    ./ocr-zettel.nix
    ./zettel_update.nix
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
      claude.enable = true;

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

  # GTK
  gtk = {
    enable = true;
    font.name = "PragmataProMono Nerd Font";
    font.size = 12;
    iconTheme.package = lib.mkForce pkgs.beauty-line-icon-theme;
    iconTheme.name = lib.mkForce "BeautyLine";
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };
  qt.platformTheme.name = "gtk3";
  qt.style.name = "gtk3";

  catppuccin = {
    gtk.icon = {
      enable = true;
      flavor = "macchiato";
      accent = "pink";
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

  # sops = {
  #   age.keyfile = "/home/felipemarcelino/.config/sops/age/keys.txt";
  #   defaultsopsfile = ./../../secrets/felipemarcelino.yaml;
  #   defaultsopsformat = "yaml";

  #   secrets = {
  #     openai_api_key = {
  #       mode = "0400";
  #     };
  #     github_personal_access_token = {
  #       mode = "0400";
  #     };
  #   };
  # };

  home.pointercursor = {
    name = "numix-cursor";
    package = pkgs.numix-cursor-theme;
    size = 24;
  };

  home.programs.mpv.enable = true;

  services.pasystray.enable = true;

  programs.yt-dlp.enable = true;

  programs.spotify-player.enable = true;
  services.spotifyd.enable = true;
  services.librespot.enable = true;

  # git
  programs.git.useremail = "felipe.marcelino1991@gmail.com";
  programs.git.username = "felipe marcelino";

  # https://nixos.wiki/wiki/faq/when_do_i_update_stateversion
  home.stateversion = "24.11";
}
