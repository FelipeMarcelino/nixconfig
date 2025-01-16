{ config, lib, ... }:
{
  programs.nixvim.plugins.todo-comments = {
    enable = true;

    lazyLoad.settings.event = [
      "BufEnter"
    ];

    keymaps = {
      todoTrouble.key = "<leader>uq";
      todoTelescope = {
        key = "<leader>ft";
        keywords = [
          "TODO"
          "FIX"
          "FIXME"
        ];
      };
    };
  };
}
