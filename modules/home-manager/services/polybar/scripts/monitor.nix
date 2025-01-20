{ pkgs, ... }:

let
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
in
pkgs.writeShellScriptBin "monitor" ''
  monitors=$(${xrandr} --listmonitors)

  if [[ $monitors == *"DP-0"* ]]; then
    echo "DP-0"
  elif [[ $monitors == *"DP-4"* ]]; then
    echo "DP-4"
  else
    echo "eDP"
  fi
''
