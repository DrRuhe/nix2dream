{self, ...}: {
  perSystem = {...}: {
    # run via `nix run n#honcho -- start -f $(nix build --print-out-paths .#packages.x86_64-linux.hello.config.public.service-managers.procfile) hello`
    deployments.nginx.services = {
      nginx = {config, ...}: {
        imports = [
          ../packages/nginx.nix
        ];
      };
    };
  };
}
