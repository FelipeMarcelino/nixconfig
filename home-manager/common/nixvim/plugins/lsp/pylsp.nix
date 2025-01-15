{
  config,
  pkgs,
  ...
}:
{

  programs.nixvim.plugins.lsp.servers.pylsp.settings = {
    configurationSources = "flake8";
    plugins = {
      black = {
        enabled = true;
        line_length = 120;
        preview = true;
        cache_config = true;
      };
      # TODO: Ignore import unused on __init__.py file: https://stackoverflow.com/questions/8427701/how-to-ignore-pyflakes-errors-imported-but-unused-in-init-py-files
      flake8 = {
        enabled = true;
        maxLineLength = 120;
        indentSize = 4;
      };
      pycodestyle = {
        enabled = false;
        maxLineLength = 120;
      };
      isort.enabled = true;
      jedi_completion = {
        enabled = true;
        cache_for = [
          "pandas"
          "numpy"
          "tensorflow"
          "matplotlib"
          "instaloader"
        ];
      };
      # jedi_definition = {
      #   enabled = true;
      # };
      # jedi_hover = {
      #   enabled = true;
      # };
      # jedi_references = {
      #   enabled = true;
      # };
      # jedi_signature_help = {
      #   enabled = true;
      # };
      # jedi_symbols = {
      #   enabled = true;
      #   all_scopes = true;
      # };
      mccabe = {
        enabled = false;
      };
      memestra = {
        enabled = false;
      };
      preload.enabled = true;
      pyflakes.enabled = false;
      pydocstyle = {
        enabled = true;
        convention = "numpy";
      };
      pylint = {
        enabled = false;
      };
      pylsp_mypy = {
        enabled = true;
        overrides = [
          "--ignore-missing-imports"
          true
        ];
      };
      rope.enabled = true;
      #rope_autoimport.enabled = true;
      yapf.enabled = false;
    };
  };
  programs.nixvim.plugins.lsp.servers.pylsp.settings = {
    configurationSources = "flake8";
    plugins = {
      black = {
        enabled = true;
        line_length = 120;
        preview = true;
        cache_config = true;
      };
      # TODO: Ignore import unused on __init__.py file: https://stackoverflow.com/questions/8427701/how-to-ignore-pyflakes-errors-imported-but-unused-in-init-py-files
      flake8 = {
        enabled = true;
        maxLineLength = 120;
        indentSize = 4;
      };
      pycodestyle = {
        enabled = false;
        maxLineLength = 120;
      };
      isort.enabled = true;
      jedi_completion = {
        enabled = true;
        cache_for = [
          "pandas"
          "numpy"
          "tensorflow"
          "matplotlib"
          "instaloader"
        ];
      };
      # jedi_definition = {
      #   enabled = true;
      # };
      # jedi_hover = {
      #   enabled = true;
      # };
      # jedi_references = {
      #   enabled = true;
      # };
      # jedi_signature_help = {
      #   enabled = true;
      # };
      # jedi_symbols = {
      #   enabled = true;
      #   all_scopes = true;
      # };
      mccabe = {
        enabled = false;
      };
      memestra = {
        enabled = false;
      };
      preload.enabled = true;
      pyflakes.enabled = false;
      pydocstyle = {
        enabled = true;
        convention = "numpy";
      };
      pylint = {
        enabled = false;
      };
      pylsp_mypy = {
        enabled = true;
        overrides = [
          "--ignore-missing-imports"
          true
        ];
      };
      rope.enabled = true;
      #rope_autoimport.enabled = true;
      yapf.enabled = false;
    };
  };
}
