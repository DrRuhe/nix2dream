# Exposes an option for flake-parts to utilize the deployments module from nix2dream. {
{
  config,
  self,
  lib,
  flake-parts-lib,
  inputs,
  ...
}: let
  l = lib // builtins;
  t = l.types;
in {
  config.perSystem = {
    pkgs,
    config,
    self',
    inputs',
    ...
  }: {
    options.deployments = l.mkOption {
      type = t.lazyAttrsOf (
        t.submoduleWith {
          modules = [
            ./../nix2dream/deployment
          ];
          specialArgs = {
            dream2nix = inputs.dream2nix;
            nixpkgs = pkgs;
            packageSets = config.nix2dream.packageSets;
          };
        }
      );
      default = {};
      description = "Deployments are a collection of services that work together.";
      example = lib.literalExpression ''TODO'';
    };

    # provide a default set of packageSets
    options.nix2dream.packageSets = l.mkOption {
      type = t.lazyAttrsOf t.raw;
      default = {
        inherit inputs';
        inherit (self') packages;
        nixpkgs = pkgs;
      };
      description = "Package sets that get passed as specialArgs to the deployment submodules, allowing them to pick their dependencies from these sources";
    };
  };

  config.flake.deployments = l.mapAttrs (system: v:
    l.mapAttrs (
      name: deployment:
        deployment.public.renderers
    )
    v.deployments)
  config.allSystems;
}
