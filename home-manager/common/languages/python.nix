{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (python311Full.withPackages (ps:
      with ps; [
        psutil
        numpy
        toolz
        pip
        pyyaml
        setuptools
      ]))
    doge
    bandit
  ];
}
