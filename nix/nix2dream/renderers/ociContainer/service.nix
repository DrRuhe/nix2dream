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
  ];
  options.service.renderers.ociContainer = {
    image-tags = l.mkOption {
      type = t.listOf t.str;
      description = ''
        A list of tags this image should be tagged with.
      '';
      default = ["${config.service.mainProgramName}:latest"];
    };

    dockerTools.buildContainer = l.mkOption {
      type = t.package;
      description = ''
        a docker container built with pkgs.dockerTools.buildComtainer
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
