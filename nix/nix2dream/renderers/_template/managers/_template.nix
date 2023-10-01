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
  # Declare specialized options like this:
  # options.renderers."Renderer".managers."Manager".XY

  # Write Actions under
  #config.public.renderers."RENDERER".managers."MANAGER"."ACTION-NAME" = pkgs.writeScriptBin "action-name" "echo Hello World!";
}
