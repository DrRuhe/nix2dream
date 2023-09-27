# Nix2Dream

Use the NixOs module system turn derivations into services that can be launched/managed by any supported service-manager:

- [x] procfile
- [ ] NixOS Service
- [ ] NixOS VM 
- [ ] Docker
  - [ ] Kubernetes
  - [ ] Docker Compose

Few features are implemented currently, but I have confidence in the architecture and that it will scale.

# Architecture 

```mermaid
flowchart LR
    subgraph nix2dream
        core["
            nix2dream-core 
            
            These modules define common options for services to set. 
            They act as a standardized way to define arguments, volumes, config files etc. 
            
            Path: ./modules/nix2dream-core
        "]
        
        renderers["
          nix2dream-renderers
          
          These modules render the service definitions. These service definitions can be script files, docker containers, NixOS modules etc.
          
          Path: ./modules/nix2dream-renderers
        "]

        managers["
          nix2dream-managers
          
          These modules create derivations that run and manage a set of services.
          
          Path: ./modules/nix2dream-managers
        "]
        
        managers -->|launch and manages definitions| renderers
        renderers -->|depends on| core
    end

    renderers -->|depends on| drvparts
    core -->|adds modules with additional options| drvparts
        
    subgraph dream2nix
        drvparts["
            drv-parts
            
            the drv-parts library allows building (and configuring) packages using the module system.
            drv-parts is now maintained inside the dream2nix library.
        "]    
    end 
    
    
```

# Open Questions:
- API design:
  - should the options be more "hidden" and should the `service` option contain the "custom" per service options?
- how to do "multiple services"?
Docker-Compose inspired:
```nix
service-collection.test = {
  services = {
    nginx = {
      imports=[../nginx.nix];
      service.port = 52131;
      service.config = {
              
      };
    };
    postgres = {
      imports=[./postgres.nix];
      
    };
  };
}
```
- how to ensure users are aware if a manager does not utilize modules?
  - let's say we have a service-manager that has no support for env variables. When the user defines env variables via service.env and the service requires them, the service manager would have no way to work, how to notify user?
  - managers warn if module options are set they don't support? Users should set an option to disable the warning.

# Migrating an Existing Service


## NixOs Services:
NixOS uses a module system as well to configure services. These services typically expose options under `service.<name>` that are an abstraction layer above `systemd.services.<name>`. As such, migrating a service from nixpkgs requires reimplementation of the module.

Here is a list of `systemd.services.<name>` options and the equivalent core options when defining a system ([source of this list](https://search.nixos.org/options?channel=unstable&show=systemd.services.%3Cname%3E.reload&from=0&size=50&sort=relevance&type=packages&query=systemd.services)):
- `systemd.services.<name>.scriptArgs` -> `service.args`
- `systemd.services.<name>.script` -> `service.mainProgram` or `service.launchCommand`, but there is no direct option to provide a `launchScript` 
- `systemd.services.<name>.path` -> `service.env` (The path interface is clean and reduces boilerplate.    )
- `systemd.services.<name>.environment` -> `service.env`
- `systemd.services.<name>.preStart` -> `service.entrypoint`

  These Options have no equivalent (yet :) ):
- `systemd.services.<name>.wants`
- `systemd.services.<name>.wantedBy`
- `systemd.services.<name>.unitConfig`
- `systemd.services.<name>.stopIfChanged`
- `systemd.services.<name>.startLimitIntervalSec`
- `systemd.services.<name>.startLimitBurst`
- `systemd.services.<name>.startAt`
- `systemd.services.<name>.serviceConfig`
- `systemd.services.<name>.restartTriggers`
- `systemd.services.<name>.restartIfChanged`
- `systemd.services.<name>.requisite`
- `systemd.services.<name>.requires`
- `systemd.services.<name>.requiredBy`
- `systemd.services.<name>.reloadTriggers`
- `systemd.services.<name>.reloadIfChanged`
- `systemd.services.<name>.reload`
- `systemd.services.<name>.preStop` 
- `systemd.services.<name>.postStop`
- `systemd.services.<name>.postStart`
- `systemd.services.<name>.partOf`
- `systemd.services.<name>.overrideStrategy`
- `systemd.services.<name>.onSuccess`
- `systemd.services.<name>.onFailure`
- `systemd.services.<name>.enable`
- `systemd.services.<name>.documentation`
- `systemd.services.<name>.description`
- `systemd.services.<name>.conflicts`
- `systemd.services.<name>.confinement.packages`
- `systemd.services.<name>.confinement.mode`
- `systemd.services.<name>.confinement.fullUnit`
- `systemd.services.<name>.confinement.enable`
- `systemd.services.<name>.confinement.binSh`
- `systemd.services.<name>.bindsTo`
- `systemd.services.<name>.before`
- `systemd.services.<name>.aliases`
- `systemd.services.<name>.after`

# TODO considerations
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

