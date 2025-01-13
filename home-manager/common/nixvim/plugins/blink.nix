{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.blink-cmp.settings = {
    appearance = {
      nerd_font_variant = "normal";
      use_nvim_cmp_as_default = true;
    };
    completion = {
      accept = {
        auto_brackets = {
          enabled = true;
          semantic_token_resolution = {
            enabled = false;
          };
        };
      };
      documentation = {
        auto_show = true;
      };
    };
    keymap = {
      preset = "default";
    };
    signature = {
      enabled = true;
    };
    sources.default = [
      "lsp"
      "path"
      "snippets"
      "buffer"
      "luasnip"
    ];
  };
}
