{ config, pkgs, ... }:
{
  programs.nixvim.plugins.codecompanion.settings = {
    strategies = {
      chat = {
        adapter = "deepseek";
      };
      inline = {
        adapter = "deepseek";
      };
    };
    opts = {
      log_level = "DEBUG";
    };
  };
}
