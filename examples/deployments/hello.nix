{self, ...}: {
  perSystem = {...}: {
    # run via `nix run n#honcho -- start -f $(nix build --print-out-paths .#packages.x86_64-linux.hello.config.public.service-managers.procfile) hello`
    deployments.hello.services = {
      hello = {
        imports = [
          ../packages/hello.nix
        ];

        service = {
          args = [
            "-g"
            ''"Hello there, $GENERAL!"''
          ];
          env.GENERAL = "General Kenobi";
        };
      };
      other-service = {
        imports = [
          ../packages/hello.nix
        ];
        service.args = [
          "-g"
          ''"Hello from the other service!"''
        ];
      };
    };
  };
}
