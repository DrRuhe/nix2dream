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
  options.service.env = l.mkOption {
    type = let
      baseTypes = [t.bool t.int t.str t.path t.package];
      allTypes = baseTypes ++ [(t.listOf (t.oneOf baseTypes))];
    in
      t.attrsOf (t.nullOr (t.oneOf allTypes));
    description = "A list of environment variables that are exposed to the service.";
    defaultText = l.literalExpression "{}";
    default = {};
    example = {FOO = "BAR";};
  };
}
