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
  options.service.renderers.ociContainer.managers.dockerCompose = {
    image = l.mkOption {
      type = t.str;
      description = "The image used by the compose.yaml. This references the images built by";
      default = config.service.renderers.ociContainer.imageTag;
    };
  };
}
