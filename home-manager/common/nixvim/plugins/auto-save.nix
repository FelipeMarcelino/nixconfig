{
  pkgs,
  config,
  ...
}: {
  programs.nixvim.plugins.auto-save.settings.write_all_buffers = true;
}
