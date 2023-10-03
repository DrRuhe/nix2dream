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
in {
  #  options.service-managers."NAME" = {
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
