{ config, pkgs, ... }:
{
  security.sudo.extraRules = [
    {
      users = [ "felipemarcelino" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/systemctl reboot";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
