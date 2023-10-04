# Migrating existing service declarations to nix2dream
The goal of this document is to provide guide and reference material to allow seamless migration from service definitions from several sources to nix2dream.
Ideally, these sections should be so informative that migrating becomes trivial, potentially even automatic using AI. If that is not the case and something is unclear, [please file an Issue](https://github.com/DrRuhe/nix2dream/issues/new/choose). 



## NixOS Services from nixpkgs: 
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