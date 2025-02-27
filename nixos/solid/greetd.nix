{
  config,
  pkgs,
  inputs,
  ...
}:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  #environment.etc."greetd/sessions/i3.desktop".text = ''i3'';

  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = " ${tuigreet}";
        user = "felipemarcelino";
      };
    };
  };
  # environment.etc."greetd/environments".text = ''
  #   i3
  # '';

  systemd.tmpfiles.rules = [
    "f /tmp/Xauth-1000 0644 felipemarcelino users -"
  ];
}
