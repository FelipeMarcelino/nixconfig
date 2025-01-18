{
  config,
  pkgs,
  ...
}: {
  programs.ruff = {
    enable = true;
    settings = {
      line-length = 120;
      indent-width = 4;
      fixable = ["ALL"];
      unfixable = [];
      dummy-variable-rgx = "^(_+|(_+[a-zA-Z0-9_]*[a-zA-Z0-9]+?))$";
      lint = {
        select = [
          "F"
          "E"
          "W"
          "C90"
          "I"
          "N"
          "D"
          "UP"
          "ANN"
          "S"
          "FBT"
          "B"
          "A"
          "COM"
          "C4"
          "DTZ"
          "ICN"
          "LOG"
          "G"
          "PIE"
          "Q"
          "RET"
          "SIM"
          "TC"
          "ARG"
          "TD"
          "FIX"
          "PD"
          "PL"
          "DOC"
          "RUF"
        ];
      };
      format = {
        quote-style = "double";
        indent-style = "space";
        skip-magic-trailing-comma = false;
        line-ending = "auto";
        docstring-code-format = false;
        docstring-code-line-length = "dynamic";
      };
    };
  };
}
