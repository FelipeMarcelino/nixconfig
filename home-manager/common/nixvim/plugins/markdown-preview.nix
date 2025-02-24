{
  config,
  lib,
  ...
}: {
  programs.nixvim.plugins.markdown-preview = {
    settings = {
      auto_close = 0;
      theme = "dark";
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>pm";
      action = "<cmd>MarkdownPreview<cr>";
      options = {
        desc = "Markdown Preview";
      };
    }
  ];
}
