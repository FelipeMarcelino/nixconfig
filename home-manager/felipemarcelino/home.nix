
# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here

  home = {
    username = "felipemarcelino";
    homeDirectory = "/home/${config.home.username}";
  };


  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  # Install firefox.
  programs.firefox.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    coreutils
    htop
    httpie
    jq
    procs
    ripgrep
    tldr
    zip
    duf 
    dust
  ];

  # My modules
  home = {
    cli = {
    	eza.enable = true;
	zoxide.enable = true;
	fzf.enable = true;
	bat.enable = true;
	startship.enable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

}
