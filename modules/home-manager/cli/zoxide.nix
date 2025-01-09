{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.home.cli.zoxide or {enable = false;};
in {
  options.home.cli.zoxide = mkOption {
    description = "Enable zoxide substitute of autojump, z and fasd";
    type = types.attrs;
    default = {enable = false;};
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
