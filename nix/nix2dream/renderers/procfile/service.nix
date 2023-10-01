{
  config,
  lib,
  specialArgs,
  ...
}: let
  l = lib // builtins;
  t = l.types;
  pkgs = specialArgs.nixpkgs;
in {
  options.service-managers.procfile = {
    launchCommand = l.mkOption {
      type = t.str;
      description = ''
        the launchCommand in the procfile:

        <defaultServiceName>: <launchCommand>
      '';
      default = let
        env-setter-string = l.concatStringsSep " " (l.mapAttrsToList (name: value: ''${name}=${l.escapeShellArg value}'') config.service.env);
      in "${env-setter-string} ${pkgs.bash}/bin/bash ${pkgs.writeScript "${config.service.mainProgram}-entrypoint" config.service.entrypoint}";
    };
  };
}
