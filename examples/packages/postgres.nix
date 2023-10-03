{
  config,
  lib,
  dream2nix,
  ...
}: {
  # select builtins-derivation as a backend for this package
  imports = [
    dream2nix.modules.dream2nix.builtins-derivation
  ];

  name = "postgresql-module";
  # TODO (dream2nix improvement) how to extract the version from nixpkgs.postgresql.version?
  version = "14.9";

  deps = {nixpkgs, ...}: {
    inherit
      (nixpkgs)
      coreutils
      postgresql
      writeShellScript
      ;
  };

  service.mainProgram = "postgres";

  # set options
  builtins-derivation =
    #  let
    #    builder = config.deps.writeShellScript "postgresql-module-builder" ''
    #
    #    '';
    #  in
    {
      builder = "/bin/sh";
      args = ["-c" "${config.deps.coreutils}/bin/ln -s ${config.deps.postgresql} $out"];
      system = "x86_64-linux";
    };
}
