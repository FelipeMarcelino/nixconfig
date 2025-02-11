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
    pragmata-monolisa-fonts
    dbeaver-bin
    jetbrains.idea-ultimate
  ];

  # My modules
  home = {

    desktop = {
      swayi3.enable = false; # wayland is broken when using nvidia proprietary driver -- waiting for 555v
      i3.enable = false;
      autorandr.enable = false;
    };

  };

  programs.granted = {
    enable = true;
    enableZshIntegration = true;
  };

  sops = {
    age.keyFile = "/home/${config.home.username}/.config/sops/age/keys.txt";
    defaultSecretsMountPoint = "${config.home.homeDirectory}/.local/share/secrets";
    defaultSopsFile = ../../sops.yaml;
    defaultSopsFormat = "yaml";
    secrets."artifactory/username" = {
      sopsFile = ../../secrets/onboarding.yaml;
      path = "${config.home.homeDirectory}/.local/share/secrets/artifactory/username";
    };

    secrets."artifactory/contexturl" = {
      sopsFile = ../../secrets/onboarding.yaml;
      path = "${config.home.homeDirectory}/.local/share/secrets/artifactory/contexturl";
    };

    secrets."artifactory/password" = {
      sopsFile = ../../secrets/onboarding.yaml;
      path = "${config.home.homeDirectory}/.local/share/secrets/artifactory/password";
    };

    secrets."homebrew_github_api_token" = {
      sopsFile = ../../secrets/onboarding.yaml;
      path = "${config.home.homeDirectory}/.local/share/secrets/homebrew_github_api_token";
    };

    secrets."openai_api_key" = {
      sopsFile = ../../secrets/onboarding.yaml;
      path = "${config.home.homeDirectory}/.local/share/secrets/openai_api_key";
    };
  };

  home.file."${config.home.homeDirectory}/.local/state/syncthing/cert.pem".source =
    ./syncthing/cert.pem;
  home.file."${config.home.homeDirectory}/.local/state/syncthing/key.pem".source =
    ./syncthing/key.pem;
  home.file."${config.home.homeDirectory}/.local/state/syncthing/config.xml".source =
    ./syncthing/config.xml;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
