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
    ./managers/skopeo/service.nix
    ./managers/dockerCompose/service.nix
  ];
  options.service.renderers.ociContainer = {
    imageTag = l.mkOption {
      type = t.str;
      description = ''
        The main tag of the image.
      '';
      default = "${config.service.mainProgramName}:${l.removePrefix "/nix/store/" config.service.renderers.ociContainer.dockerTools.buildContainer.drvPath}";
    };

    extraImageTags = l.mkOption {
      type = t.listOf t.str;
      description = ''
        A list of additional tags this image should be tagged with.
      '';
      default = [];
    };

    allImageTags = l.mkOption {
      type = t.listOf t.str;
      description = ''
        A list of tags this image should be tagged with.
        This is a readonly option. Instead see the imageTag and extraImageTags options.
      '';
      default = [config.service.renderers.ociContainer.imageTag] ++ config.service.renderers.ociContainer.extraImageTags;
      readOnly = true;
    };

    dockerTools.buildContainer = l.mkOption {
      type = t.package;
      description = ''
        a docker container built with pkgs.dockerTools.buildContainer
      '';
      default = deps.dockerTools.buildLayeredImage {
        name = config.service.mainProgramName;
        config = {
          # The entrypoint script already sets the environment variables.
          Entrypoint = [config.service.entrypoint];
        };
      };
    };
  };
}
