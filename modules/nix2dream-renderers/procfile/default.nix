{self, ...}: {
  imports = [
    # list all the supported core modules of this manager here
    ../../nix2dream-core
    # self.modules.nix2dream-core.args
    ./implementation.nix
  ];
}
