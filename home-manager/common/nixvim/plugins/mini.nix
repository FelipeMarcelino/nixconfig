{ config, lib, ... }:
{
  programs.nixvim.plugins = {
    mini = {
      mockDevIcons = true;

      modules = {
        ai = { };
        align = { };
        icons = { };
        snippets = {
          snippets = {
            __unkeyed-1.__raw = "require('mini.snippets').gen_loader.from_file('${config.programs.nixvim.plugins.friendly-snippets.package}/snippets/global.json')";
            __unkeyed-2.__raw = "require('mini.snippets').gen_loader.from_lang()";
          };
        };
      };
    };
  };
}
