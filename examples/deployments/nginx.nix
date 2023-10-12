{self, ...}: {
  perSystem = {...}: {
    deployments.nginx.services = {
      nginx = {config, ...}: {
        imports = [
          ../packages/nginx.nix
        ];
      };
    };
  };
}
