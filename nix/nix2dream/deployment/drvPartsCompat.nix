{
  lib,
  flake-parts-lib,
  inputs,
  ...
}: let
  l = lib // builtins;
  t = l.types;
in {
  options = {
    nix2dream.packageSets = l.mkOption {
      type = t.lazyAttrsOf t.raw;

      description = ''
        Define the package sets which can be used to pick dependencies from.
        Basically this specifies the arguments passed to the function defined via drvs.<name>.deps.
      '';
      example = lib.literalExpression ''
        {
          inherit pkgs inputs';
        }
      '';
    };
  };
}
