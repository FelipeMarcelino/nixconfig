# Home-manager configuration for WSL2 Ubuntu
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../common
    ./zsh.nix
    ./xdg.nix
  ];

  home = {
    username = "felipemarcelino";
    homeDirectory = "/home/${config.home.username}";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # WSL-focused packages (CLI tools, development tools, no GUI apps)
  home.packages = with pkgs; [
    # Development tools
    cookiecutter
    claude-code

    # Fonts (for terminal)
    pragmata-monolisa-fonts
  ];

  # Disable all desktop/GUI modules for WSL
  home = {
    desktop = {
      swayi3.enable = false;
      i3.enable = false;
      autorandr.enable = false;
    };

    programs = {
      rofi.enable = false;
      yt-dlp.enable = false;
      firefox.enable = false;
      feh.enable = false;
      zathura.enable = false;
    };

    services = {
      polybar.enable = false;
      dunst.enable = false;
      udiskie.enable = false;
      screen-locker-x.enable = false;
      picom.enable = false;
      emanote-site.enable = false;
    };

    # Enable CLI tools for WSL
    cli = {
      aws.enable = true;
      azure.enable = true;
    };
  };

  # Git configuration
  programs.git.userEmail = "felipe.marcelino1991@gmail.com";
  programs.git.userName = "Felipe Marcelino";

  # Catppuccin theming for CLI tools
  catppuccin = {
    starship.enable = true;
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
    yazi = {
      enable = true;
      flavor = "macchiato";
    };
  };

  # SOPS secrets management (if needed on WSL)
  # Uncomment and configure if you need secrets on WSL
  # sops = {
  #   age.keyFile = "/home/felipemarcelino/.config/sops/age/keys.txt";
  #   defaultSopsFile = ./../../secrets/felipemarcelino.yaml;
  #   defaultSopsFormat = "yaml";
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
