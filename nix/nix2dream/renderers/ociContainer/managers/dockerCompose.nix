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
  #settings = config.public.renderers."MANAGER";
  #rendered = config.public.renderers."MANAGER".out;
in {
  # Write Actions under
  config.public.renderers.ociContainer.managers.dockerCompose.up = pkgs.writeScriptBin "docker-compose-up" ''echo "This is a placeholder for docker compose up :)"'';
}
