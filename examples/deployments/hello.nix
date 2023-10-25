{self, ...}: {
  perSystem = {...}: {
    # With this deployment the renderers and managers defined allow you to:
    # run it:
    #   - `nix run .#deployments.x86_64-linux.hello.procfile.managers.honcho.start` runs as a procfile-based application using honcho
    #   - `nix run .#deployments.x86_64-linux.hello.procfile.managers.hivemind.start` runs as a procfile-based application using hivemind
    # build artifacts to use otherwise:
    #   - `nix run .#deployments.x86_64-linux.hello.procfile.out`
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
          renderers.ociContainer.extraImageTags = [
            "kenobi-greeter:latest"
          ];
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
