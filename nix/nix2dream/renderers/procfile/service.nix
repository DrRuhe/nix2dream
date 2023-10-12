{
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
  options.renderers.procfile = {
    launchCommand = l.mkOption {
      type = t.oneOf [t.str t.package];
      description = ''
        the launchCommand in the procfile:

        <defaultServiceName>: <launchCommand>
      '';
      default = config.service.entrypoint;
    };
  };
}
