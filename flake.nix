{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dream2nix.url = "path:./dream2nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts-auto={
      url = "github:DavHau/flake-parts-auto";
      inputs.flake-parts.follows = "flake-parts";
    };
  };
  outputs = inputs:
    inputs.flake-parts-auto.mkFlake {
      inherit inputs;
      systems = ["x86_64-linux"];
      modulesDir = ./modules;
    };
}