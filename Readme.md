

What does a Service potentially need?

- Basic Needs:
    - environment Variables -> ./drv-parts/modules/drv-parts/env/default.nix
    - config files
    - command line arguments
    - Users/Permissions

- Advanced:
    - Volumes
        - named directories
        - can (and should) be done via env-vars
    - liveness probes?
    - CLI interface(?)


Which modules can encapsulate those needs?



Potential Service Managers Targets:

- NixOs Services
- NixOs VMs
- Containerized
    - docker compose
    - local kubernetes?
- procfile