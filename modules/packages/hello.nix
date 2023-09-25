{config,dream2nix,...}:{
  # select builtins-derivation as a backend for this package
  imports = [dream2nix.modules.dream2nix.mkDerivation];

  name = "hello";
  version = "2.12";

  deps = {nixpkgs, ...}: {
    inherit
      (nixpkgs)
      stdenv
      ;
  };

  mkDerivation = {
    src = builtins.fetchTarball {
      url = "https://ftp.gnu.org/gnu/hello/hello-${config.version}.tar.gz";
      sha256 = "sha256-4GQeKLIxoWfYiOraJub5RsHNVQBr2H+3bfPP22PegdU=";
    };
  };
}
