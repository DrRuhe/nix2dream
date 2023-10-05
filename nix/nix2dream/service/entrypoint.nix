{
  config,
  lib,
  ...
}: let
  l = lib // builtins;
  t = l.types;
  # get the derivation of the current package,
  derivation = config.public.out;
in {
  options.service = {
    # TODO set meta.mainProgram as default instead if it is unset.
    mainProgramName = l.mkOption {
      type = t.str;
      description = ''
        The name of the binary that gets executed
        The logic for the default value is taken from the "description" section of `nix run --help`
      '';
      default =
        derivation.meta.mainProgram
        or derivation.pname
        or derivation.name;
    };

    mainProgram = l.mkOption {
      type = t.str;
      description = ''
        The binary that gets executed.
      '';
      default = "${derivation}/bin/${config.service.mainProgramName}";
    };

    preStart = l.mkOption {
      type = t.oneOf [t.str t.lines];
      description = ''
        A script that is executed before the mainProgram is called with its arguments
      '';
      defaultText = l.literalExpression ''"$\{derivation}/bin/$\{config.service.mainProgram} $\{l.concatStringsSep " " config.service.args}"'';
      default = "";
    };

    entrypoint = l.mkOption {
      type = t.package;
      description = ''
        The script that is run to start up the service.

        By default, this script handles:
        - setting env vars
        - making sure volumes are initialized correctly
        - running the preStart script
        - launching the mainProgram with its arguments

        So when setting this option yourself, keep in mind that some renderers might build their own entrypoint to better suit their capabilities.
      '';
      default = let
        # The env vars cannot be passed as an env file, since that would mean all services share their env vars, which is not desired, as each service sets their own vars.
        env-setters = l.concatStringsSep "\n" (l.mapAttrsToList (name: value: ''export ${name}=${l.escapeShellArg value}'') config.service.env);
        volume-initializers = l.concatStringsSep "\n" (l.mapAttrsToList (name: volume: ''
            # Setting up volume ${name}
            ${volume.initializeScript}
            ${
              if (! volume.persisting)
              then volume.clearScript
              else ""
            }
            ${volume.checkScript}

          '')
          config.service.volumes);
      in
        config.deps.writeScript "${config.service.mainProgram}-entrypoint" ''
          set -euo pipefail

          # Setting the env variables
          ${env-setters}

          ${volume-initializers}

          ${config.service.preStart}

          ${config.service.mainProgram} ${l.concatStringsSep " " config.service.args}
        '';
    };
  };
}
