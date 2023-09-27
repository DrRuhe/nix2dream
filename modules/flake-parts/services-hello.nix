{
  inputs,
  self,
  ...
}: {
  perSystem = {...}: {
    drvs.hello = {
      imports = [
        self.modules.packages.hello
        self.modules.nix2dream-core.default

        # run via `nix run n#honcho -- start -f $(nix build --print-out-paths .#packages.x86_64-linux.hello.config.public.service-managers.procfile) hello`
        self.modules.nix2dream-renderers.procfile
      ];

      service.args = [
        "-g"
        ''"Hello there, $GENERAL!"''
      ];

      service.env.GENERAL = "General Knobi";

      #      service.env = {
      #        FOO = "BAR";
      #      };

      #      service.files."config" = {
      #        target = "/home/caspar";
      #      };

      #      Look at how nix2container manages these:
      #      service.permissions = {
      #
      #      };
    };
  };
}
