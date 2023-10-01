{self, ...}: {
  perSystem = {...}: {
    # run via `nix run n#honcho -- start -f $(nix build --print-out-paths .#packages.x86_64-linux.hello.config.public.service-managers.procfile) hello`
    deployments.hello = {
      services.hello = {
        imports = [
          ../packages/hello.nix
        ];

        #default = {};
        service.args = [
          "-g"
          ''"Hello there, $GENERAL!"''
        ];

        service.env.GENERAL = "General Knobi";

        #      service.files."config" = {
        #        target = "/home/caspar";
        #      };

        #      Look at how nix2container manages these:
        #      service.permissions = {
        #
        #      };
      };
    };
  };
}
