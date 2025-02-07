{ config, pkgs, ... }:
{

  progrmas.nixvim.plugins.codecompanion.setttings = {
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
