{
  config,
  lib,
  ...
}: let
  l = lib // builtins;
  t = l.types;
  # get the derivation of the current package,
  derivation = config.public.out;
in {
  imports = [
    ./args.nix
  ];

  options.service = {
    # TODO set meta.mainProgram as default instead if it is unset.
    mainProgram = l.mkOption {
      type = t.str;
      description = ''
        The binary name that gets executed
        Logic taken from the "description" section of `nix run --help`
      '';
      default =
        derivation.meta.mainProgram
        or derivation.pname
        or derivation.name;
    };

    entrypoint = l.mkOption {
      type = t.str;
      description = ''
        The script that is initialized at startup of the service.

        The entrypoint should contain the values of `service.args` as they are not passed to the entrypoint again.
      '';
      defaultText = l.literalExpression ''"$\{derivation}/bin/$\{config.service.mainProgram} $\{l.concatStringsSep " " config.service.args}"'';
      default = "${derivation}/bin/${config.service.mainProgram} ${l.concatStringsSep " " config.service.args}";
    };
  };
}
