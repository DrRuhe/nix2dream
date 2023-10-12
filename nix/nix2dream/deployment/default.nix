{
  lib,
  config,
  specialArgs,
  self,
  ...
}: let
  l = lib // builtins;
  t = l.types;
in {
  imports = [
    ./../renderers/allDeployments.nix
    ./drvPartsCompat.nix
  ];

  options = {
    services = l.mkOption {
      type = t.lazyAttrsOf (
        t.submoduleWith {
          modules = [
            specialArgs.dream2nix.modules.dream2nix.core
            ./../service
          ];
          # TODO improve error handling when some special Args are missing

          specialArgs =
            specialArgs;
        }
      );
      default = {};
      description = "The services that should be deployed";
    };

    public.renderers = l.mkOption {
      type = t.lazyAttrsOf (t.submodule {
        options.out = l.mkOption {
          type = t.package;
          description = "Rendered Deployment Configurations per renderer. These can be executed by using the contained files manually or by using a manager";
        };
        options.managers = l.mkOption {
          type = t.attrsOf (t.attrsOf t.package);
          default = {};
          description = ''
            Runnable Actions from the Managers grouped by:

            public.renderers.<renderer>.managers.<manager>.<action-name>

            renderer: name of a renderer. e.g. procfile or docker-compose
            manager: which tool will act upon the rendered configuration. e.g. hocho for procfiles, docker-compose for docker-compose files, etc.
            action-name: managers can do several things with a configuration.
          '';
        };
      });
    };
  };
}
