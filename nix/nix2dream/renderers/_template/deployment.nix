{
  self,
  config,
  lib,
  specialArgs,
  ...
}: let
  l = lib // builtins;
  t = l.types;
  deps = config.deps;
  services = config.services;
in {
  imports = [
    #./managers/NAME/service.nix
  ];
  # Declare specialized options like this:
  #options.renderers."NAME"

  # Write a Package to:
  #config.public.renderers."NAME".out
}
