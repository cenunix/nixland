{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, ...
}:
with lib; let
  cfg = config.modules.system.server;
  service-name = "${config.virtualisation.oci-containers.backend}";
in
{
  config = mkIf (cfg.mediaServer) {
    environment.systemPackages = with pkgs; [
      rclone_rd
    ];
    systemd.services."${service-name}-debrid" = {
      preStart = ''sleep 30'';
      serviceConfig = {
        Restart = "always";
        TimeoutStartSec = lib.mkForce 35;
        TimeoutStopSec = lib.mkForce 15;
      };
      wantedBy = [ "graphical.target" ];
    };

    systemd.services."${service-name}-nginx-pm" = {
      preStart = ''sleep 15'';
    };
    systemd.services.docker-net = {
      script = ''
        ${pkgs.docker}/bin/docker network inspect mynet123 >/dev/null 2>&1 || \
        ${pkgs.docker}/bin/docker network create --subnet=172.18.0.0/16 mynet123
      '';
      wantedBy = [ "graphical.target" ];
      serviceConfig = {
        Type = "oneshot";
      };
    };
    systemd.services.rclone-linux = {
      script = ''
        ${pkgs.rclone_rd}/bin/rclone mount plex: /home/cenunix/mount --dir-cache-time 10s --vfs-cache-mode full --vfs-cache-max-size 60G --vfs-cache-max-age 4h --allow-other --allow-non-empty --config /home/cenunix/.config/rclone/rclone.conf
      '';
      wantedBy = [ "graphical.target" ];
      bindsTo = [ "docker-debrid.service" "docker-plex.service" "docker-jackett.service" "docker-overseerr.service" ];
      serviceConfig = {
        Type = "simple";
      };
    };
    # systemd.services.foo = {
    #   script = ''
    #     if ${pkgs.docker}/bin/docker run --rm -i -v=realdebrid:/tmp/myvolume busybox find /tmp/myvolume | grep -q '/tmp/myvolume'; then
    #       systemctl stop docker-plex
    #       mkdir -p /var/lib/docker-plugins/rclone/config
    #       mkdir -p /var/lib/docker-plugins/rclone/cache
    #       ${pkgs.docker}/bin/docker volume prune -f
    #       ${pkgs.docker}/bin/docker plugin inspect rclone >/dev/null 2>&1 || ${pkgs.docker}/bin/docker plugin install itstoggle/docker-volume-rclone_rd:amd64 args="-v" --alias rclone --grant-all-permissions config=/var/lib/docker-plugins/rclone/config cache=/var/lib/docker-plugins/rclone/cache
    #       ${pkgs.docker}/bin/docker volume inspect realdebrid >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create realdebrid -d rclone -o type=realdebrid -o allow-other=true -o dir-cache-time=10s -o realdebrid-api_key=${builtins.readFile config.age.secrets.mediaserver.path}
    #       systemctl start docker-plex
    #     fi
    #   '';
    #   wantedBy = [ "graphical.target" ];
    #   serviceConfig = {
    #     Type = "oneshot";
    #   };
    # };
    systemd.extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    virtualisation = {
      docker = {
        enable = true;
        # enableNvidia = true;
      };
      oci-containers = {
        backend = "docker";

        containers.plex = {
          image = "lscr.io/linuxserver/plex:latest";
          autoStart = true;
          extraOptions = [
            "--network=host"
            "--device=/dev/dri:/dev/dri"
            # "--restart=unless-stopped"
            # "--pull=always"
          ];
          environment = {
            TZ = "America/Los_Angeles";
            PUID = "1000";
            PGID = "1000";
            AUTO_UPDATE = "true";
            VERSION = "docker";
          };
          volumes = [
            "/home/cenunix/mediaserver:/config"
            "/home/cenunix/mount/movies:/movies"
            "/home/cenunix/mount/shows:/shows"
          ];
        };
        containers.debrid = {
          image = "itstoggle/plex_debrid";
          autoStart = true;
          extraOptions = [
            "--network=host"
            "--interactive"
            # "--restart=unless-stopped"
            # "--pull=always"
          ];
          environment = {
            TZ = "America/Los_Angeles";
            PUID = "1000";
            PGID = "1000";
            AUTO_UPDATE = "true";
            VERSION = "docker";
          };
          volumes = [
            "/home/cenunix/mediaserver/plex_debrid:/config"
          ];
        };
        containers.jackett = {
          image = "lscr.io/linuxserver/jackett:latest";
          autoStart = true;
          # extraOptions = [
          #   "--restart=unless-stopped"
          # ];
          environment = {
            TZ = "America/Los_Angeles";
            PUID = "1000";
            PGID = "1000";
            AUTO_UPDATE = "true";
            VERSION = "docker";
          };
          ports = [
            "9117:9117"
          ];
          volumes = [
            "/home/cenunix/mediaserver:/config"
            "/dev/null:/downloads"
          ];
          # extraOptions = [ "--pull=always" ];
        };
        containers.overseerr = {
          image = "sctx/overseerr:latest";
          autoStart = true;
          extraOptions = [
            "--network=mynet123"
            "--ip=172.18.0.22"
          ];
          environment = {
            TZ = "America/Los_Angeles";
            PUID = "1000";
            PGID = "1000";
            AUTO_UPDATE = "true";
            VERSION = "docker";
            LOG_LEVEL = "debug";
            PORT = "5055"; #optional
          };
          ports = [
            "5055:5055"
          ];
          volumes = [
            "/home/cenunix/mediaserver:/app/config"
          ];
          # extraOptions = [ "--pull=always" ];
        };
        containers.nginx-pm = {
          image = "jc21/nginx-proxy-manager:latest";
          autoStart = true;
          extraOptions = [
            "--network=mynet123"
            "--ip=172.18.0.23"
          ];
          ports = [
            "80:80"
            "443:443"
            "81:81"
          ];
          volumes = [
            "/home/cenunix/mediaserver/nginx-pm/data:/data"
            "/home/cenunix/mediaserver/nginx-pm/letsencrypt:/etc/letsencrypt"
          ];
        };
        containers.plex-metam = {
          image = "lscr.io/linuxserver/plex-meta-manager:latest";
          autoStart = true;
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "America/Los_Angeles";
          };
          volumes = [
            "/home/cenunix/mediaserver/plex-meta-manager:/config"
          ];
        };
      };
    };
  };
}
