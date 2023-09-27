{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dream2nix.url = "path:./dream2nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };
  outputs = {
    haumea,
    flake-parts,
    ...
  } @ inputs: let
    src = haumea.lib.load {
      src = ./nix;
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        src.flake-parts.default
        src.flake-parts.services-hello
      ];

      flake.modules.nix2dream = src.nix2dream.all-modules;
    };
}
