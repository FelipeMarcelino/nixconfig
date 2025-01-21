{ pkgs, ... }:

let
  task = "${pkgs.xorg.taskwarrior3}/bin/task";
in
pkgs.writeShellScriptBin "gettaskin" ''
  while true; do
    ${task} +in +PENDING count
    sleep 1
  done
''
