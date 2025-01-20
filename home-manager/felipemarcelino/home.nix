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
  programs.firefox.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    coreutils
    htop-vim
    httpie
    jq
    procs
    ripgrep
    tldr
    zip
    duf
    dust
    unzip
    pragmata-monolisa-fonts
    element-desktop
    discord
  ];

  imports = [ ./zsh.nix ];

  # Walppapers
  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/.wallpappers/ 0755 felipemarcelino wheel - -"
  ];
  home.file."${config.home.homeDirectory}/.wallpappers/vertical.png".source =
    ../../wallpapers/solid/monitor_vertical/forrest.png;
  home.file."${config.home.homeDirectory}/.wallpappers/horizontal.jpg".source =
    ../../wallpapers/solid/monitor_horizontal/shaded_landscape.jpg;

  # My modules
  home = {
    cli = {
      eza.enable = true;
      zoxide.enable = true;
      fzf.enable = true;
      bat.enable = true;
      starship.enable = true;
      git.enable = true;
    };

    desktop = {
      swayi3.enable = false; # wayland is broken when using nvidia proprietary driver -- waiting for 555v
      i3.enable = true;
      autorandr.enable = true;
    };

    terminal.ghostty.enable = true;
    programd = {
      rofi.enable = true;
      feh.enable = true;
      zathura.enable = true;
    };

    services = {
      polybar.enable = true;
      dunst.enable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
