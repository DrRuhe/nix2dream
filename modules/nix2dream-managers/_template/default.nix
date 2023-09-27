{self, ...}: {
  imports = [
    # list all the supported core modules of this manager here
    self.modules.nix2dream-core.args
    ./implementation.nix
  ];
}
