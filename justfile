
check:
    nix flake update .#
    nix flake show .# || true

repl: check
    nix repl '<nixpkgs>'
