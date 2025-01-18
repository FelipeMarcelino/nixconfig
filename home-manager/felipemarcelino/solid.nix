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
    inputs.self.homeManagerModules.terminal
    inputs.self.homeManagerModules.programs
  ];
}
