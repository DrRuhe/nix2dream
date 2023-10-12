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
  # See https://github.com/containers/skopeo/blob/main/docs/skopeo.1.md#image-names for possible destinations.
  config.public.renderers.ociContainer.managers.skopeo.copyToLocalRegistry = let
    skopeoCopyInstructions = l.mapAttrsToList (serviceName: cfg: cfg.service.renderers.ociContainer.managers.skopeo.pushTagsToLocalRegistry) services;
  in
    pkgs.writeScriptBin "skopeo-copy-to-local-registry" (l.concatStringsSep "\n" skopeoCopyInstructions);
}
