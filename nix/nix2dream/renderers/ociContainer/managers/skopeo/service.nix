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

  rendererCfg = config.service.renderers.ociContainer;
  managerCfg = rendererCfg.managers.skopeo;
  # The built container:
  container = rendererCfg.dockerTools.buildContainer;
in {
  options.service.renderers.ociContainer.managers.skopeo = {
    pushBuilder = l.mkOption {
      type = t.functionTo t.lines;
      description = ''
        A function that takes a docker image label as an argument and returns the necessary script lines to push the service container there.
      '';
      default = image-tag: ''
        ${deps.skopeo}/bin/skopeo copy --insecure-policy docker-archive:${container} ${image-tag}
      '';
    };

    pushTagsToLocalRegistry = l.mkOption {
      type = t.lines;
      description = ''
        Script lines to push the container to the local registry
      '';
      default = let
        skopeoCopyInstructions = l.map (image-tag: managerCfg.pushBuilder "docker-daemon:${image-tag}") rendererCfg.image-tags;
      in (l.concatStringsSep "\n" skopeoCopyInstructions);
    };
  };
}
