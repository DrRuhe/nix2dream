{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dream2nix.url = "github:nix-community/dream2nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };
  outputs = {flake-parts, ...} @ inputs: let
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./nix/flake-parts
        ./nix/flake-parts/nix2dream.nix
        ./examples/deployments/hello.nix
        ./examples/deployments/nginx.nix
      ];

      perSystem = {
        apps = {};
      };

      flake = {
        flakeModule = ./nix/flake-parts/nix2dream.nix;
        standaloneSubmodule = ./nix/nix2dream/deployment;
      };
    };
}
