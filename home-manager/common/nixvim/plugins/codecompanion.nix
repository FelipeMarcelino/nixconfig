{ config, pkgs, ... }:
let
  api_key_path = ''${config.sops.secrets."openai_api_key".path}'';
in
{
  programs.nixvim.plugins.codecompanion.settings = {
    adapters = {
      openai = {
        __raw = ''
          function()
            local function read_api_key(file_path)
              local file = io.open(file_path, "r")
              if file then
                local api_key = file:read("*all")
                file:close()
                return api_key:gsub("%s+", "")  -- trim whitespace/newlines
              else
                error("Failed to open file: " .. file_path)
              end
            end

            local api_key = read_api_key("${api_key_path}")
            return require('codecompanion.adapters').extend('openai', {
              env = {
                api_key = api_key
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
