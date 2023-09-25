{config, lib, packageSets, ...}: let
  lib = lib // builtins;
  ty = l.types;
in {
  options = {
    files = l.mkOption {


      type = ty.attrsOf ty.submoduleWith {
        options.path = l
      };
      default = {};
    };

    env = lib.mkOption {
      type = let
        baseTypes = [ty.bool ty.int ty.str ty.path ty.package];
        allTypes = baseTypes ++ [(t.listOf (t.oneOf baseTypes))];
      in
        t.attrsOf (t.nullOr (t.oneOf allTypes));
      default = {};
    };
  };
}
