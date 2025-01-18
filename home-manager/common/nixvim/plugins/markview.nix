{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.markview = {
    lazyLoad = {
      settings = {
        ft = "markdown";
      };
    };
    settings = {
      buf_ignore = [];

      modes = [
        "n"
        "x"
        "i"
        "r"
      ];

      hybrid_modes = [
        "i"
        "r"
      ];
    };
  };
}
