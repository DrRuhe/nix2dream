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
    ./managers/dockerCompose.nix
    ./managers/skopeo/deployment.nix
  ];

  # Declare specialized options like this:

  # Write a Package to:
  #config.public.renderers."NAME".out
}
