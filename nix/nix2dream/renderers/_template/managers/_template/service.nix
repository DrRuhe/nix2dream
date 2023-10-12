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
  #rendererCfg = config.service.renderers."RENDERER";
  #managerCfg = rendererCfg.managers."MANAGER";
in {
  #  options.service.renderers."MANAGER_NAME".managers."RENDERER_NAME" = {
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
