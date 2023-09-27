
check:
    nix flake update .#
    nix flake show .# || true

repl: check
    nix repl '<nixpkgs>'

docs PACKAGE:
    nix build .#packages.x86_64-linux.{{PACKAGE}}.docs
    xdg-open ./result/index.html
