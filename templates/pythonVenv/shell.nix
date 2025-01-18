{
  pkgs,
  lib,
  stdenv,
  ...
}:

let
  pythonPackages = pkgs.python3Packages;
in
pkgs.mkShell {
  buildInputs = [
    pythonPackages.python
    pythonPackages.venvShellHook
    pythonPackages.numpy
    pythonPackages.numba
    pythonPackages.pandas
    pythonPackages.tensorflow
    pythonPackages.ruff
    pythonPackages.python-lsp-server

  ];
  venvDir = "./.venv";
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
  '';
  postShellHook = ''
    unset SOURCE_DATE_EPOCH
    export LD_LIBRARY_PATH=${lib.makeLibraryPath [ stdenv.cc.cc ]}
  '';
}
