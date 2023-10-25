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
  yaml = pkgs.formats.yaml {};
in {
  options.renderers.ociContainer.managers.dockerCompose.composeYaml = l.mkOption {
    type = yaml.type;
    description = ''
      A settings submodule that will be 1-to-1 tranformed into the docker compose.
      Thus this can be used to set special values in the docker compose that are not natively exposed by nix2dream.
    '';
    default = {
      services = let
        serviceMapper = (
          serviceName: serviceCfg: let
            serviceComposeCfg = serviceCfg.service.renderers.ociContainer.managers.dockerCompose;
          in {
            image = serviceComposeCfg.image;
          }
        );
      in
        l.mapAttrs serviceMapper services;
    };
  };

  config.public.renderers.ociContainer.managers.dockerCompose = {
    composeYaml = yaml.generate "compose.yaml" config.renderers.ociContainer.managers.dockerCompose.composeYaml;
    run = pkgs.writeScriptBin "docker-compose" "${pkgs.docker-compose}/bin/docker-compose -f ${config.public.renderers.ociContainer.managers.dockerCompose.composeYaml} $@";
    up = pkgs.writeScriptBin "docker-compose-up" "${pkgs.docker-compose}/bin/docker-compose -f ${config.public.renderers.ociContainer.managers.dockerCompose.composeYaml} up --pull never --no-build $@";
  };
}
