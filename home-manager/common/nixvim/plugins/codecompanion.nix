{ config, pkgs, ... }:
let
  OPENAI_REFACTOR = ''
    [[Your task is to refactor the provided code snippet, focusing specifically on its readability and maintainability.
    Identify any issues related to:
    - Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
    - The presence of unnecessary comments, or the lack of necessary ones.
    - Overly complex expressions that could benefit from simplification.
    - High nesting levels that make the code difficult to follow.
    - The use of excessively long names for variables or functions.
    - Any inconsistencies in naming, formatting, or overall coding style.
    - Repetitive code patterns that could be more efficiently handled through abstraction or optimization.
    ]]
  '';
  OPENAI_REVIEW = ''
    [[Your task is to review the provided code snippet, focusing specifically on its readability and maintainability.
    Identify any issues related to:
    - Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
    - The presence of unnecessary comments, or the lack of necessary ones.
    - Overly complex expressions that could benefit from simplification.
    - High nesting levels that make the code difficult to follow.
    - The use of excessively long names for variables or functions.
    - Any inconsistencies in naming, formatting, or overall coding style.
    - Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

    Your feedback must be concise, directly addressing each identified issue with:
    - A clear description of the problem.
    - A concrete suggestion for how to improve or correct the issue.
      
    Format your feedback as follows:
    - Explain the high-level issue or problem briefly.
    - Provide a specific suggestion for improvement.
     
    If the code snippet has no readability issues, simply confirm that the code is clear and well-written as is.
    ]]
  '';

  OPENAI_EXPLAIN = ''
    [[You are a world-class coding tutor. Your code explanations perfectly balance high-level concepts and granular details. Your approach ensures that students not only understand how to write code, but also grasp the underlying principles that guide effective programming.
    When asked for your name, you must respond with "GitHub Copilot".
    Follow the user's requirements carefully & to the letter.
    Your expertise is strictly limited to software development topics.
    Follow Microsoft content policies.
    Avoid content that violates copyrights.
    For questions not related to software development, simply give a reminder that you are an AI programming assistant.
    Keep your answers short and impersonal.
    Use Markdown formatting in your answers.
    Make sure to include the programming language name at the start of the Markdown code blocks.
    Avoid wrapping the whole response in triple backticks.
    The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
    The active document is the source code the user is looking at right now.
    You can only give one reply for each conversation turn.

    Additional Rules
    Think step by step:
    1. Examine the provided code selection and any other context like user question, related errors, project details, class definitions, etc.
    2. If you are unsure about the code, concepts, or the user's question, ask clarifying questions.
    3. If the user provided a specific question or error, answer it based on the selected code and additional provided context. Otherwise focus on explaining the selected code.
    4. Provide suggestions if you see opportunities to improve code readability, performance, etc.

    Focus on being clear, helpful, and thorough without assuming extensive prior knowledge.
    Use developer-friendly terms and analogies in your explanations.
    Identify 'gotchas' or less obvious parts of the code that might trip up someone new.
    Provide clear and relevant examples aligned with any provided context.
    ]]
  '';
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
        roles = {
          llm = "Open Ai Chat";
          user = "IT Man/Data Scientist";
        };
        slash_commands = {
          buffer = {
            callback = "strategies.chat.slash_commands.buffer";
            description = "Insert open buffers";
            opts = {
              contains_code = true;
              provider = "fzf_lua"; # default|telescope|mini_pick|fzf_lua
            };
          };
          file = {
            callback = "strategies.chat.slash_commands.file";
            description = "Insert a file";
            opts = {
              contains_code = true;
              max_lines = 1000;
              provider = "fzf_lua"; # telescope|mini_pick|fzf_lua
            };
          };
        };
        keymaps = {
          send = {
            modes = {
              n = "<CR>";
              i = "<C-CR>";
            };
            index = 1;
            callback = "keymaps.send";
            description = "Send";
          };
          close = {
            modes = {
              n = "q";
            };
            index = 3;
            callback = "keymaps.close";
            description = "Close Chat";
          };
          stop = {
            modes = {
              n = "<C-c>";
            };
            index = 4;
            callback = "keymaps.stop";
            description = "Stop Request";
          };
        };
      };
      inline = {
        adapter = "openai";
      };
      agent = {
        adapter = "openai";
      };

    };

    opts = {
      log_level = "DEBUG";
    };

    prompt_library = {
      "Generate a Commit Message" = {
        prompts = [
          {
            content = {
              __raw = ''
                function()
                  return "Write commit message with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
                    .. "\n\n```\n"
                    .. vim.fn.system("git diff")
                    .. "\n```"
                end
              '';
            };
            opts = {
              contains_code = true;
            };
          }
        ];
      };
      "Explain" = {
        strategy = "chat";
        opts = {
          default_prompt = true;
          modes = [ "v" ];
          short_name = "explain";
          auto_subimit = true;
          user_prompt = false;
          stop_context_insertion = true;
        };
        prompts = [
          {
            role = "system";
            content = "${OPENAI_EXPLAIN}";
            opts = {
              visible = false;
            };
          }
          {
            role = "user";
            content = {
              __raw = ''
                function(context)
                                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                                return "Please explain how the following code works:\n\n```"
                                  .. context.filetype
                                  .. "\n"
                                  .. code
                                  .. "\n```\n\n"
                              end
              '';

            };
            opts = {
              contains_code = true;
            };
          }
        ];
      };
      "Explain Code" = {
        strategy = "chat";
        opts = {
          short_name = "explain-code";
          auto-submit = false;
          is_slash_cmd = true;
        };
        prompts = [
          {
            role = "system";
            content = "${OPENAI_EXPLAIN}";
            opts = {
              visible = false;
            };
          }
          {
            role = "user";
            content = "[[Please explain how the following code works.]]";
          }
        ];
      };
      "Generate a Commit Message for Staged" = {
        strategy = "chat";
        opts = {
          short_name = "staged-commit";
          auto-submit = true;
          is_slash_cmd = true;
        };
        prompts = [
          {
            role = "user";
            content = {
              __raw = ''
                function()
                  return "Write commit message for the change with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
                    .. "\n\n```\n"
                    .. vim.fn.system("git diff --staged")
                    .. "\n```"
                end
              '';
            };
            opts = {
              contains_code = true;
            };
          }
        ];
      };
      "Inline Document" = {
        strategy = "inline";
        opts = {
          modes = [ "v" ];
          short_name = "inline-doc";
          auto-submit = true;
          user_promt = false;
          stop_context_insertion = true;
        };
        prompts = [
          {
            role = "user";
            content = {
              __raw = ''
                function (context)
                  local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                  return "Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.\n\n```"
                      .. context.filetype
                      .. "\n"
                      .. code
                      .. "\n```\n\n"
                  end
              '';
            };
            opts = {
              contains_code = true;
            };
          }
        ];
      };
      "Document" = {
        strategy = "chat";
        opts = {
          modes = [ "v" ];
          short_name = "doc";
          auto_submit = true;
          user_prompt = false;
          stop_context_insertion = true;
        };
        prompts = [
          {
            role = "user";
            content = {
              __raw = ''
                function (context)
                  local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                  return "Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.\n\n```"
                    .. context.filetype
                    .. "\n"
                    .. code
                    .. "\n```\n\n"
                  end
              '';
            };
            opts = {
              contains_code = true;
            };
          }
        ];
      };
      "Review" = {
        strategy = "chat";
        opts = {
          modes = [ "v" ];
          short_name = "review";
          auto_submit = true;
          user_prompt = false;
          stop_context_insertion = true;
        };
        prompts = [
          {
            role = "system";
            content = "${OPENAI_REVIEW}";
            opts = {
              visible = false;
            };
          }
          {
            role = "user";
            content = {
              __raw = ''
                function(context)
                                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                                return "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```"
                                  .. context.filetype
                                  .. "\n"
                                  .. code
                                  .. "\n```\n\n"
                              end
              '';
            };
            opts = {
              contains_code = true;
            };
          }
        ];
      };
      "Review Code" = {
        strategy = "chat";
        opts = {
          short_name = "review-code";
          auto_submit = false;
          is_slash_cmd = true;
        };
        prompts = [
          {
            role = "system";
            content = "${OPENAI_REVIEW}";
            opts = {
              visible = false;
            };
          }
          {
            role = "user";
            content = "Please review the following code and provide suggestions for improvement then refactor the
            following code to improve its clarity and readability.";
          }
        ];
      };
      "Refactor" = {
        strategy = "inline";
        opts = {
          modes = [ "v" ];
          short_name = "refactor";
          auto_submit = true;
          user_prompt = false;
          stop_context_insertion = true;
        };
        prompts = [
          {
            role = "system";
            content = "${OPENAI_REFACTOR}";
            opts = {
              visible = false;
            };
          }
          {
            role = "user";
            content = {
              __raw = ''
                function(context)
                                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                                return "Please refactor the following code to improve its clarity and readability:\n\n```"
                                  .. context.filetype
                                  .. "\n"
                                  .. code
                                  .. "\n```\n\n"
                              end
              '';
            };
            opts = {
              contains_code = true;
            };
          }
        ];
      };
      "Refactor Code" = {
        strategy = "chat";
        opts = {
          short_name = "refactor-code";
          auto_submit = false;
          is_slash_cmd = true;
        };
        prompts = [
          {
            role = "system";
            content = "${OPENAI_REFACTOR}";
            opts = {
              visible = false;
            };
          }
          {
            role = "user";
            content = "Please refactor the following code to improve its clarity and readability.";
          }
        ];
      };
      "Naming" = {
        strategy = "inline";
        opts = {
          modes = [ "v" ];
          short_name = "naming";
          auto_submit = true;
          user_prompt = false;
          stop_context_insertion = true;
        };
        prompts = [
          {
            role = "user";
            content = {
              __raw = ''
                function(context)
                                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                                return "Please provide better names for the following variables and functions:\n\n```"
                                  .. context.filetype
                                  .. "\n"
                                  .. code
                                  .. "\n```\n\n"
                              end
              '';
            };
            opts = {
              contains_code = true;
            };
          }
        ];
      };
      "Better Naming" = {
        strategy = "chat";
        opts = {
          short_name = "better-naming";
          auto_submit = false;
          is_slash_cmd = true;
        };
        prompts = [
          {
            role = "user";
            content = "Please provide better names for the following variables and functions.";
          }
        ];
      };
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

    {
      mode = "v";
      key = "<leader>cn";
      action = "<cmd>CodeCompanion /naming<CR>";
      options = {
        desc = "CodeCompanion - Better Naming";
      };
    }

    {
      mode = "v";
      key = "<leader>cr";
      action = "<cmd>CodeCompanion /refactor<CR>";
      options = {
        desc = "CodeCompanion - Refactor Code";
      };
    }

    {
      mode = "v";
      key = "<leader>cR";
      action = "<cmd>CodeCompanion /review<CR>";
      options = {
        desc = "CodeCompanion - Review Code";
      };
    }

    {
      mode = "v";
      key = "<leader>cd";
      action = "<cmd>CodeCompanion /inline-doc<CR>";
      options = {
        desc = "CodeCompanion - Inline Document Code";
      };
    }

    {
      mode = "v";
      key = "<leader>cD";
      action = "<cmd>CodeCompanion /doc<CR>";
      options = {
        desc = "CodeCompanion - Document Code";
      };
    }

    {
      mode = "n";
      key = "<leader>co";
      action = "<cmd>CodeCompanion /commit<CR>";
      options = {
        desc = "CodeCompanion - Git Commit Message";
      };
    }

    {
      mode = "n";
      key = "<leader>cO";
      action = "<cmd>CodeCompanion /staged-commit<CR>";
      options = {
        desc = "CodeCompanion - Git Commit Message (staged)";
      };
    }

    {
      mode = "v";
      key = "<leader>ct";
      action = "<cmd>CodeCompanion /tests<CR>";
      options = {
        desc = "CodeCompanion - Generate Unit Test";
      };
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cl";
      action = "<cmd>CodeComapnion /lsp<CR>";
      options = {
        desc = "CodeCompanion - Exlpain LSP Diagnostic";
      };
    }

    {
      mode = "v";
      key = "<leader>cf";
      action = "<cmd>CodeCompanion /fix<CR>";
      options = {
        desc = "CodeCompanion - Fix code";
      };
    }

    {
      mode = "v";
      key = "<leader>ce";
      action = "<cmd>CodeCompanion /explain<CR>";
      options = {
        desc = "Code Comapnaion - Explain code";
      };
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ct";
      action = "<cmd>CodeCompanionChat Toggle<CR>";
      options = {
        desc = "Code Companion Toggle";
      };
    }
  ];
}
