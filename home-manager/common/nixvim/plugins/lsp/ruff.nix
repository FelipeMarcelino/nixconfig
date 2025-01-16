{ config, pkgs, ... }:
{
  programs.nixvim.plugins.lsp.servers.ruff.extraOptions = {
    init_options.settings.args = [
      "--config=${config.home.homeDirectory}/.config/ruff.toml"
    ];
  };

  home.file."${config.home.homeDirectory}/.config/ruff.toml".source = ./ruff.toml;
}
