{
  config,
  lib,
  ...
}: let
  l = lib // builtins;
  t = l.types;
in {
  options.service.volumes = l.mkOption {
    description = "Volumes that are available to the service.";
    default = {};
    type = t.attrsOf (t.submodule (inputs: let
      volumeCfg = inputs.config;
    in {
      options = {
        path = l.mkOption {
          description = "The path to the volume";
          type = t.oneOf [t.str t.path];
        };
        persisting = l.mkOption {
          description = "If the volume should persist restarts";
          default = true;
          type = t.bool;
        };

        checkScript = l.mkOption {
          description = "A script that checks if the volume is valid";
          default = ''${config.deps.coreutils}/bin/test -d ${volumeCfg.path}'';
          type = t.oneOf [t.str t.lines t.package];
        };

        initializeScript = l.mkOption {
          description = "A script that ensures the volume is initialized correctly";
          default = ''${config.deps.coreutils}/bin/mkdir -p ${volumeCfg.path}'';
          type = t.oneOf [t.str t.lines t.package];
        };

        clearScript = l.mkOption {
          description = "A script that clears the contents of a volume";
          default = ''${config.deps.coreutils}/bin/rm -rf ${volumeCfg.path}'';
          type = t.oneOf [t.str t.lines t.package];
        };
      };
    }));
  };
}
