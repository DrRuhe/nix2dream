{
  self,
  config,
  lib,
  specialArgs,
  ...
}: let
  l = lib // builtins;
  t = l.types;
  pkgs = specialArgs.nixpkgs;
  services = config.services;
in {
  imports = [
    #super.managers.<MANAGER>
  ];
  # Declare specialized options like this:
  #options.renderers."NAME"

  # Write a Package to:
  #config.public.renderers."NAME".out
}
