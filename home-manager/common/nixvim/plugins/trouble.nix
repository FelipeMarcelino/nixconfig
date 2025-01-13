{ config, pkgs, ...}:
{
  programs.nixvim.plugins.trouble = {
    autoLoad = true;
    settings = {
    auto_close  = true;
    auto_refresh = true;
    focus = true;
      follow = true;
  };
  };
}
