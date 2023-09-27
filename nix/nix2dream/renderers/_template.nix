{
  root,
  super,
  self,
}: {
  config,
  lib,
  ...
}: let
  l = lib // builtins;
  t = l.types;
in {
  imports = [
    # list all the supported core modules of this manager here
    self.modules.nix2dream-core.args
  ];
}
