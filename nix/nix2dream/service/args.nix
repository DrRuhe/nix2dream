{
  config,
  lib,
  ...
}: let
  l = lib // builtins;
  t = l.types;
in {
  options.service.args = l.mkOption {
    type = t.listOf (t.oneOf [t.str t.path]);
    description = ''
      A list of arguments to pass to the service.
    '';
    default = [];
    defaultText = "[]";
    example = ["--help" "--version"];
  };
}
