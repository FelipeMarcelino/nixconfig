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
    username = "onboarding";
    homeDirectory = "/home/${config.home.username}";
  };

  imports = [ ./zsh.nix ];

  # Install firefox.
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
  ];

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
      i3.enable = false;
      autorandr.enable = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
