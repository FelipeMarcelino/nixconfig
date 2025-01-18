{
  inputs,
  config,
  ...
}:
{
  imports = [
    ./home.nix
    ../common
    inputs.self.homeManagerModules.cli
    inputs.self.homeManagerModules.desktop
    inputs.self.homeManagerModules.termial
    inputs.self.homeManagerModules.programs
  ];
}
