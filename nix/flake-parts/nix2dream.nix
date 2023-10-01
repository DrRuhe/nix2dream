# Exposes an option for flake-parts to utilize the deployments module from nix2dream. {
{
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
      description = "Deployments are a collection of services that work together.";
      example = lib.literalExpression ''
        TODO write an example for how deployments are configured
      '';
    };

    #TODO: Expose the rendered configs somehow
    #    config.packages.honchotest = config.deployments.hello.services.hello;
    config.packages.honchotest = config.deployments.hello.public.renderers.procfile.managers.honcho.start;

    #    let
    #        deployments = l.mapAttrs (name: deployment: deployment.public.renderers) ((_:break _) config.deployments);
    #    in
    #        deployments;
  };

  options.flake = flake-parts-lib.mkSubmoduleOptions {
    deployments = l.mkOption {
      # TODO: make this more strict
      type = t.nullOr t.raw;
      default = {};
      description = ''
        See {option}`perSystem.deployments` for description and examples.
      '';
    };
  };
}
