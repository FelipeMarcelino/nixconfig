{
  config,
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    inputs.sops-nix.homeManagerModules.sops
    inputs.catppuccin.homeManagerModules.catppuccin

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./zsh.nix
    ./xdg.nix
    ./nixvim
    inputs.self.homeManagerModules.cli
    inputs.self.homeManagerModules.desktop
    inputs.self.homeManagerModules.terminal
    inputs.self.homeManagerModules.programs
    inputs.self.homeManagerModules.services

  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  fonts.fontconfig.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim.defaultEditor = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    nerd-fonts.monaspace
    xclip
    trash-cli
    pwvucontrol
    pavucontrol
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
    age
    sops
  ];

  home = {
    cli = {
      eza.enable = true;
      zoxide.enable = true;
      fzf.enable = true;
      bat.enable = true;
      starship.enable = true;
      git.enable = true;
    };

    programs = {
      feh.enable = true;
      zathura.enable = true;
      zettelkasten.enable = true;
      taskwarrior.enable = true;
      broot.enable = true;
      yazi.enable = true;
      firefox.enable = true;
    };
  };

  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/.config/sops/age/ 0755 ${config.home.username} - -"
  ];

  home.file.".XCompose".text = ''
    include "%L"
    <dead_acute> <C> : "Ç"
    <dead_acute> <c> : "ç"
  '';

  # syncthing

  services.syncthing = {
    enable = true;
  };

  home.services.emanote-site = {
    enable = true;
    path = "/home/felipemarcelino/Zettelkasten/content";
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh.initExtra = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

  services.pasystray.enable = true;
}
