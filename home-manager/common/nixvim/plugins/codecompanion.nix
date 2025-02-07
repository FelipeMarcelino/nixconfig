{ config, pkgs, ... }:
{
  programs.nixvim.plugins.codecompanion.settings = {
    adapters = {
      openai = {
        __raw = ''
          function()
            return require('codecompanion.adapters').extend('openai', {
                env = {
                  api_key =
                  "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";
                },
                schema = {
                model = {
                  default = "o1-mini-2024-09-12"
                }
              }
            })
          end
        '';
      };
    };
    strategies = {
      chat = {
        adapter = "openai";
      };
      inline = {
        adapter = "openai";
      };
    };
    opts = {
      log_level = "DEBUG";
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ch";
      action = "<cmd>CodeCompanionChat<CR>";
      options = {
        desc = "CodeCompanionChat";
      };
    }

    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>CodeCompanionActions<CR>";
      options = {
        desc = "CodeCompanionActions";
      };
    }

    {
      mode = "n";
      key = "<leader>cm";
      action = "<cmd>CodeCompanionCmd<CR>";
      options = {
        desc = "CodeCompanionCmd";
      };
    }
  ];
}

