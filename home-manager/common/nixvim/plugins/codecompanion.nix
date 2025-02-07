{ config, pkgs, ... }:
let
  api_key = ''${builtins.readFile config.sops.secrets."openai_api_key".path}'';

in
{
  programs.nixvim.plugins.codecompanion.settings = {
    adapters = {
      openai = {
        __raw = ''
          function()
            return require('codecompanion.adapters').extend('openai', {
                env = {
                  api_key = "${api_key}"
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
