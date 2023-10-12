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
  settings = config.public.renderers.procfile;
  rendered = config.public.renderers.procfile.out;
in {
  # Declare specialized options like this:
  # options.renderers."Renderer".managers."Manager".XY

  # Write Actions under
  #config.public.renderers."RENDERER".managers."MANAGER"."ACTION-NAME"
  config.public.renderers.procfile.managers.hivemind.start = pkgs.writeScriptBin "deployment-hivemind" "${pkgs.hivemind}/bin/hivemind --print-timestamps ${rendered}";
}
