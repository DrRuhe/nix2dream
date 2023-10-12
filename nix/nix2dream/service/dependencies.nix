# Lists the dependencies required for correct operation of nix2dream functionality.
{lib, ...}: {
  deps = packageSets: (builtins.mapAttrs (_: package: lib.mkDefault package)
    (let
      pkgs = packageSets.nixpkgs or (builtins.throw "nix2dream requires a nixpkgs instance in the packageSets under the `nixpkgs` key.");
    in {
      inherit
        (pkgs)
        coreutils
        writeScript
        dockerTools
        skopeo
        bash
        ;
    }));
}
