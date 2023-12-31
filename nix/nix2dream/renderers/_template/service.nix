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
  #  options.service.renderers."NAME" = {
  #    optionName = l.mkOption {
  #      type = t.oneOf [t.str t.package];
  #      description = ''
  #        the launchCommand in the procfile:
  #
  #        <defaultServiceName>: <launchCommand>
  #      '';
  #      default = config.service.entrypoint;
  #    };
  #  };
}
