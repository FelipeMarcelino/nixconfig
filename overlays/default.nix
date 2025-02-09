# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    aider = prev.aider.overrideAttrs (oldAttrs: rec {
      version = "0.72.3";
      # Override the src using the new hash from the PR.
      src = prev.fetchFromGitHub {
        owner = "Aider-AI";
        repo = "aider";
        tag = "v${version}";
        hash = "sha256-aOdLaH/95i2/h86rH578Z9iAtQSf7rI0PvnZQEx4Yjs=";
      };
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  aider = import ./aider.nix;
}
