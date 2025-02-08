{ config, pkgs, ... }:
{
  security.sudo.extraRules = [
    {
      users = [ "felipemarcelino" ];
      commands = [
        {
          commands = "/usr/bin/systemctl reboot";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
