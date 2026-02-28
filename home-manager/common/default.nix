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

  # nixpkgs config is inherited from the system-level pkgs instance (useGlobalPkgs = true)

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
    buku
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
    fdupes
    aider-chat
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

  sops = {
    age.keyFile = "/home/felipemarcelino/.config/sops/age/keys.txt";
    defaultSopsFile = ./../../secrets/felipemarcelino.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      OPENAI_API_KEY = {
        mode = "0400";
      };
    };
  };

  home.file.".XCompose".text = ''
    include "%L"
    <dead_acute> <C> : "Ç"
    <dead_acute> <c> : "ç"
  '';

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh.initExtra = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

}
