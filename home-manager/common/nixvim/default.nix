{
  config,
  pkgs,
  lib,
  ...
}:
let

  inherit (builtins) fetchurl;
  inherit (lib.modules) mkForce;
  inherit (lib.meta) getExe;
in
{
  imports = [
    ./keymapping.nix
    ./options.nix
    ./plugins.nix
    ./plugins
    ./filetype.nix
    ./performance.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;

    extraConfigLuaPre = ''
      -- Allow unfree packages for nixvim
    '';

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    diagnostics = {
      virtual_text = false;
    };

    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings = {
      flavour = "mocha";
    };

    extraPython3Packages = python-pkgs: [
      python-pkgs.tasklib
      python-pkgs.packaging
    ];

    globals = {
      "taskwiki_data_location" = "/home/felipemarcelino/Taskwarrior/";
    };
  };
  xdg.desktopEntries."nvim" = {
    name = "Neovim";
    type = "Application";
    mimeType = [ "text/plain" ];

    icon = fetchurl {
      url = "https://raw.githubusercontent.com/NotAShelf/nvf/main/.github/assets/nvf-logo-work.svg";
      sha256 = "sha256:19n7n9xafyak35pkn4cww0s5db2cr97yz78w5ppbcp9jvxw6yyz3";
    };

    exec =
      let
        ghostty = getExe pkgs.ghostty;
        direnv = getExe pkgs.direnv;
      in
      "${pkgs.writeShellScript "ghostty-neovim" ''
        # define target filename
        filename="$(readlink -f "$1")"

        # get the directory target file is in
        dirname="$(dirname "$filename")"

        # launch a ghostty instance with direnv and nvim
        ${ghostty} --working-directory="$dirname" --command="${direnv} exec . nvim '$filename'"
      ''} %f";
  };

}
