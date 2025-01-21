{ pkgs, ... }:

let
  task = "${pkgs.taskwarrior3}/bin/task";
in
pkgs.writeShellScriptBin "gettaskin" ''
  while true; do
    echo $(${task} +in +PENDING count)
  done
''
