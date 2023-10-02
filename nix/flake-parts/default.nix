# This module configures the devshell and tooling to work on dream2nix.
{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule
  ];

  perSystem = {
    config,
    self',
    inputs',
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      inputsFrom = builtins.attrValues self'.checks ++ builtins.attrValues self'.packages;
      nativeBuildInputs = [
        # make treefmt available in the shell
        config.treefmt.build.wrapper
      ];

      shellHook = "
                ${config.pre-commit.installationScript}

                echo Welcome to the devshell for nix2dream!
            ";

      #ENV_VAR="test";
    };
    treefmt = {
      projectRootFile = "./flake.nix";
      # Formatters (See https://flake.parts/options/treefmt-nix.html#options ):
      programs = {
        alejandra.enable = true; # Nix
        #black.enable = true; # Python
        #shellcheck.enable = true; # Bash
      };
    };
    # Configure commit hooks (see https://flake.parts/options/pre-commit-hooks-nix.html)
    pre-commit = {
      check.enable = false;
      settings = {
        # Automagically uses the defined treefmt because of https://github.com/cachix/pre-commit-hooks.nix/blob/master/flake-module.nix#L71C13-L71C112
        hooks.commitizen.enable = true;
        hooks.treefmt.enable = true;
      };
    };
  };
}
