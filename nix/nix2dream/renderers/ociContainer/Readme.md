# Template Description

[//]: # (Short motivation of why it makes sense to render to this format.)

## Special Options

[//]: # (list out special options, or referr the user on how to generate the required documentation)

## Outputs
- `deployments.<name>.<renderer>.out`
- `deployments.<name>.<renderer>.<manager-name>.<action-name>`



> **_NOTE:_**  These outputs reference the flake outputs exposed when using `nix2dream.flakeModule` inside a flake-parts flake. When using the standalone module, these are under `deployments.<name>.public.{...}` 