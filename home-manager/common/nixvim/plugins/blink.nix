{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.extraPlugins = [
    pkgs.vimPlugins.blink-ripgrep-nvim
  ];

  programs.nixvim.plugins = lib.mkMerge [
    {
      blink-cmp = {
        settings = {
          completion = {
            ghost_text.enabled = true;
            documentation = {
              auto_show = true;
              window.border = "rounded";
            };
            list.selection = {
              auto_insert = true;
              preselect = false;
            };
            menu = {
              border = "rounded";
              draw = {
                columns = [
                  {
                    __unkeyed-1 = "label";
                  }
                  {
                    __unkeyed-1 = "kind_icon";
                    __unkeyed-2 = "kind";
                    gap = 1;
                  }
                  { __unkeyed-1 = "source_name"; }
                ];
                components = {
                  kind_icon = {
                    ellipsis = false;
                    text.__raw = ''
                      function(ctx)
                        local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                        return kind_icon
                      end,
                      -- Optionally, you may also use the highlights from mini.icons
                      highlight = function(ctx)
                        local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                        return hl
                      end
                    '';
                  };
                };
              };
            };
          };
          fuzzy = {
            prebuilt_binaries = {
              download = false;
              ignore_version_mismatch = true;
            };
          };
          appearance = {
            use_nvim_cmp_as_default = true;
          };
          keymap = {
            preset = "enter";
            "<A-Tab>" = [
              "snippet_forward"
              "fallback"
            ];
            "<A-S-Tab>" = [
              "snippet_backward"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
          };
          signature = {
            enabled = true;
            window.border = "rounded";
          };

          snippets.preset = "mini_snippets";
          sources = {
            default = [
              # BUILT-IN SOURCES
              "buffer"
              "lsp"
              "path"
              "snippets"
              "codecompanion"
              # Community
              "ripgrep"
              # Cmp sources
              # TODO: migrate when available
              "calc"
              "git"
              "spell"
              "zsh"
              "cmp-vimwiki-tags"
            ];
            providers = {
              # BUILT-IN SOURCES
              lsp.score_offset = 4;
              # Community sources
              codecompanion = {
                name = "CodeCompanion";
                module = "codecompanion.providers.completion.blink";
                score_offset = 110;
                enabled = true;
              };
              ripgrep = {
                name = "Ripgrep";
                module = "blink-ripgrep";
                score_offset = 1;
              };
              # Cmp sources
              calc = {
                name = "calc";
                module = "blink.compat.source";
                score_offset = 2;
              };
              git = {
                name = "git";
                module = "blink.compat.source";
                score_offset = 0;
              };
              npm = {
                name = "npm";
                module = "blink.compat.source";
                score_offset = -3;
              };
              spell = {
                name = "spell";
                module = "blink.compat.source";
                score_offset = -1;
              };
              zsh = {
                name = "zsh";
                module = "blink.compat.source";
                score_offset = -3;
              };
              cmp-vimwiki-tags = {
                name = "cmp-vimwiki-tags";
                module = "blink.compat.source";
                score_offset = -0;
              };
            };
          };
        };
      };

      blink-cmp-copilot.enable = true;

      blink-compat = {
        enable = true;

        settings = {
          debug = true;
          impersonate_nvim_cmp = true;
        };
      };
    }
    {
      cmp-calc.enable = true;
      cmp-git.enable = true;
      #cmp-nixpkgs_maintainers.enable = true;
      # cmp-npm.enable = true;
      cmp-spell.enable = true;
      # cmp-treesitter.enable = true;
      cmp-zsh.enable = true;
      cmp-vimwiki-tags.enable = true;

      lsp.capabilities =
        # Lua
        ''
          capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
        '';
    }
  ];
}
