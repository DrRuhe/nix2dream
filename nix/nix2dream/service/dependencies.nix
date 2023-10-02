# Lists the dependencies required for correct operation of nix2dream functionality.
{lib, ...}: {
  deps = {nixpkgs, ...}: (builtins.mapAttrs (_: package: lib.mkDefault package) {
    inherit
      (nixpkgs)
      coreutils
      writeScript
      ;
  });
}
