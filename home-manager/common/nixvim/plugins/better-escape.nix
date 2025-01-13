{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.better-escape.settings = {
    mapping = ["jj" "jk"];
    timeout = 500;
  };
}
