{
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
    ./managers/honcho.nix
    ./managers/hivemind.nix
  ];
  # Declare specialized options like this:
  #options.renderers."NAME"

  # TODO this is likely broken
  config.public.renderers.procfile.out = let
    launchScripts = builtins.mapAttrs (serviceName: service: service.service-managers.procfile.launchCommand) config.services;
    procfileLines = l.mapAttrsToList (serviceName: launchScript: "${serviceName}: ${launchScript}") launchScripts;
  in
    #TODO Get the name of the deployment here to allow customized name of procfile
    pkgs.writeText "Procfile" (l.concatStringsSep "\n" procfileLines);
}
