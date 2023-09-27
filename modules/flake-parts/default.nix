{inputs, ...}: {
  imports = [
    # import the dream2nix integration for flake-parts
    inputs.dream2nix.modules.flake-parts.dream2nix
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

                echo Welcome to a generic Flake Project!
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
        hooks.treefmt.enable = true;
        hooks.commitizen.enable = true;

        # see https://github.com/cachix/pre-commit-hooks.nix#custom-hooks
        hooks.nix-flake-check = {
          enable = true;
          name = "nix-flake-check";
          entry = "nix flake check -L";
          pass_filenames = false;
        };
      };
    };
  };
}
