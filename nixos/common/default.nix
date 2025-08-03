# Common configuration for all hosts

# In nixos/common/default.nix
{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    ./users
    inputs.home-manager.nixosModules.home-manager

    inputs.self.nixosModules.programs
    inputs.self.nixosModules.services
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # Replace your entire 'nix' block with this one
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "felipemarcelino"
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) (
      lib.filterAttrs (_: lib.isType "flake") inputs
    );
    # This line sets the NIX_PATH for legacy commands
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  users.defaultUserShell = pkgs.zsh;
}
