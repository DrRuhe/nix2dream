{
  config,
  lib,
  packageSets,
  ...
} @ module-inputs: let
  l = lib // builtins;
  t = l.types;
  pkgs = packageSets.nixpkgs;
  env-setter-string = l.concatStringsSep " " (l.mapAttrsToList (name: value: ''${name}=${l.escapeShellArg value}'') config.service.env);
in {
  config.public.service-managers.procfile = pkgs.writeText "${config.service.mainProgram}-procfile" ''
    ${config.service.mainProgram}:${env-setter-string} ${pkgs.bash}/bin/bash ${pkgs.writeScript "${config.service.mainProgram}-entrypoint" config.service.entrypoint}
  '';
}
