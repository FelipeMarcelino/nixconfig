{ config, lib, ... }:
{
  programs.nixvim.plugins = {

    settings = {
      CursorLine = true;
      DiffAutoOpen = true;
      DiffCommand = "diff";
      DiffpanelHeight = 10;
      HelpLine = true;
      HighlightChangedText = true;
      HighlightChangedWithSign = true;
      HighlightSyntaxAdd = "DiffAdd";
      HighlightSyntaxChange = "DiffChange";
      HighlightSyntaxDel = "DiffDelete";
      RelativeTimestamp = true;
      SetFocusWhenToggle = true;
      ShortIndicators = false;
      TreeNodeShape = "*";
      TreeReturnShape = "\\";
      TreeSplitShape = "/";
      TreeVertShape = "|";
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>uu";
      action = "<cmd>UndotreeToggle<CR>";
      options = {
        desc = "Undotree toggle";
      };
    }
  ];
}
