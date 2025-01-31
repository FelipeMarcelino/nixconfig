{
  config,
  pkgs,
  inputs,
  ...
}:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  i3-session = "${config.users.users.felipemarcelino.home}/.local/share/xsessions";
in
{
  environment.etc."greetd/sessions/i3.desktop".text = ''i3'';

  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --user-menu --cmd i3";
        user = "felipemarcelino";
      };
    };
  };

}
