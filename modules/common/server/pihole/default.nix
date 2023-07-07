{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.server;
in {
  config = mkIf (cfg.pihole) {
    virtualisation = {
      oci-containers = {
        backend = "docker";

        containers.pihole = {
          image = "pihole/pihole:latest";
          ports = [
            "53:53/tcp"
            "53:53/udp"
            "67:67/udp"
            "3080:80"
            "30443:443"
          ];
          volumes = [
            "/var/lib/pihole/:/etc/pihole/"
            "/var/lib/dnsmasq.d:/etc/dnsmasq.d/"
          ];
          environment = {
            FTL_CMD = "no-daemon -- --dns-forward-max 450";
            WEB_PASSWORD = "johnny";
            TZ = "America/Los_Angeles";
          };
          extraOptions = [
            "--cap-add=NET_ADMIN"
            "--dns=127.0.0.1"
            "--dns=1.1.1.1"
          ];
          workdir = "/var/lib/pihole/";
        };
      };
    };
  };
}
