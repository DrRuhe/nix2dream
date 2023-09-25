{inputs,self,...}:{
  perSystem = {...}: {
    drvs.hello = {
      imports = [self.modules.packages.hello];

      service.env = {
        FOO = "BAR";
      };
      service.files."config" = {
        target = "/home/caspar";
      };

#      Look at how nix2container manages these:
#      service.permissions = {
#
#      };


    };
  };
}
