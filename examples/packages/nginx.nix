{
  config,
  lib,
  dream2nix,
  flake-root,
  ...
}: let
  l = lib // builtins;
  t = l.types;
  configFile = config.deps.writeText "nginx.conf" ''
    pid ${config.service.volumes.NGINX_DATA.path}/nginx.pid;
    error_log stderr debug;
    daemon off;

    events {
      ${config.service.eventsConfig}
    }

    http {
      access_log off;
      client_body_temp_path ${config.service.volumes.NGINX_DATA.path};
      proxy_temp_path ${config.service.volumes.NGINX_DATA.path};
      fastcgi_temp_path ${config.service.volumes.NGINX_DATA.path};
      scgi_temp_path ${config.service.volumes.NGINX_DATA.path};
      uwsgi_temp_path ${config.service.volumes.NGINX_DATA.path};

      ${config.service.httpConfig}
    }
  '';
in {
  # select builtins-derivation as a backend for this package
  imports = [
    dream2nix.modules.dream2nix.builtins-derivation
  ];

  options.service = {
    httpConfig = l.mkOption {
      description = "the http config for nginx";
      default = "";
      type = t.oneOf [t.str t.lines];
    };

    eventsConfig = l.mkOption {
      type = t.lines;
      default = "";
      description = "The nginx events configuration.";
    };

    configFile = l.mkOption {
      type = t.path;
      default = configFile;
      description = "The nginx configuration file.";
    };
  };

  config = {
    name = "nginx";
    # TODO (dream2nix improvement) how to extract the version from nixpkgs.postgresql.version?
    version = "1.24.0";

    deps = {nixpkgs, ...}: {
      inherit
        (nixpkgs)
        coreutils
        nginx
        writeText
        ;
    };

    service = {
      volumes.NGINX_DATA.path = "/home/caspar/.local/share/temp/drv-parts-systems/.volumes";
      args = ["-c" config.service.configFile];
    };

    builtins-derivation = {
      builder = "/bin/sh";
      args = ["-c" "${config.deps.coreutils}/bin/ln -s ${config.deps.nginx} $out"];
      system = "x86_64-linux";
    };
  };
}
