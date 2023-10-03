{self, ...}: {
  perSystem = {...}: {
    # run via `nix run n#honcho -- start -f $(nix build --print-out-paths .#packages.x86_64-linux.hello.config.public.service-managers.procfile) hello`
    deployments.postgres.services = {
      pg = {config, ...}: {
        imports = [
          ../packages/postgres.nix
        ];

        service = {
          args = [
          ];
          env.PGDATA = "General Kenobi";
        };
      };
    };
  };
}
