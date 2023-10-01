# nix2dream procfile renderer

Renders a service definition into a [procfile](https://pythonhosted.org/deis/using_deis/process-types/#:~:text=A%20Procfile%20is%20a%20text,that%20process%20type%20is%20started.). These are simple files  where each line represents a managed service with its launch commands like this `<process-name>: <launch commands>`. A complete procfile might look like this:

```procfile
hello: echo hello world!
ping: ping github.com
work: ./some_important_work.sh
```

## Special Options

This renderer exposes no special options

## Outputs
- `deployments.<name>.procfile.out` - the generated procfile  
- `deployments.<name>.procfile.honcho.start` - start the services using [honcho](https://github.com/nickstenning/honcho) as a process-manager.



> **_NOTE:_**  These outputs reference the flake outputs exposed when using `nix2dream.flakeModule` inside a flake-parts flake. When using the standalone module, these are under `deployments.<name>.public.{...}` 