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
    systemd.services.foo = {
      script = ''
        if ${pkgs.docker}/bin/docker run --rm -i -v=realdebrid:/tmp/myvolume busybox find /tmp/myvolume | grep -q '/tmp/myvolume'; then
          systemctl stop docker-plex
          mkdir -p /var/lib/docker-plugins/rclone/config
          mkdir -p /var/lib/docker-plugins/rclone/cache
          ${pkgs.docker}/bin/docker volume prune -f
          ${pkgs.docker}/bin/docker plugin inspect rclone >/dev/null 2>&1 || ${pkgs.docker}/bin/docker plugin install itstoggle/docker-volume-rclone_rd:amd64 args="--network-mode --transfers=8 --buffer-size=128M -v" --alias rclone --grant-all-permissions config=/var/lib/docker-plugins/rclone/config cache=/var/lib/docker-plugins/rclone/cache
          ${pkgs.docker}/bin/docker volume inspect realdebrid >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create realdebrid -d rclone -o type=realdebrid -o allow-other=true -o dir-cache-time=60s -o --vfs-read-ahead=512M -o vfs-read-chunk-size=128M -o vfs-read-chunk-size-limit=2G -o vfs-cache-mode=full -o vfs-cache-max-age=5h -o vfs-cache-max-size=150G -o realdebrid-api_key=${builtins.readFile config.age.secrets.mediaserver.path}
          systemctl start docker-plex
        fi
      '';
      wantedBy = [ "graphical.target" ];
      serviceConfig = {
        Type = "oneshot";
      };
    };
    # services.jellyfin = {
    #   enable = true;
    #   openFirewall = true;
    # };
    environment.systemPackages = with pkgs; [
      rclone
      filebot
      nodejs_20
    ];
    systemd.timers."filebot-timer" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "filebot-timer.service";
      };
    };

    systemd.services."filebot-timer" = {
      script = ''
        set -eu
        ${pkgs.curl}/bin/curl "http://io:5452/task?id=0"
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
    };
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
      after = [ "docker-plex.service" ];
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
    systemd.extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    virtualisation = {
      docker = {
        enable = true;
        liveRestore = false;
        # enableNvidia = true;
      };
      oci-containers = {
        backend = "docker";

        containers.plex = {
          image = "plexinc/pms-docker";
          autoStart = false;
          extraOptions = [
            "--network=mynet123"
            "--device=/dev/dri:/dev/dri"
            "--ip=172.18.0.24"
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
            "/home/cenunix/Media/organized:/organized"
            "realdebrid:/rclone_RD"
          ];
        };
        containers.jellyfin = {
          image = "jellyfin/jellyfin";
          autoStart = false;
          extraOptions = [
            "--network=mynet123"
            "--ip=172.18.0.27"
            "--device=/dev/dri:/dev/dri"
            "--group-add=303"
          ];
          environment = {
            TZ = "America/Los_Angeles";
            PUID = "1000";
            PGID = "1000";
          };
          volumes = [
            "/home/cenunix/mediaserver/jellyfin/config:/config"
            "/home/cenunix/mediaserver/jellyfin/cache:/cache"
            "/home/cenunix/Media/organized:/organized"
            "realdebrid:/rclone_RD"
          ];
          ports = [
            "8096:8096"
          ];
        };
        containers.emby = {
          image = "emby/embyserver";
          autoStart = false;
          extraOptions = [
            "--network=mynet123"
            "--device=/dev/dri:/dev/dri"
            "--ip=172.18.0.28"
          ];
          environment = {
            TZ = "America/Los_Angeles";
            PUID = "1000";
            PGID = "1000";
            AUTO_UPDATE = "true";
            VERSION = "docker";
          };
          ports = [
            "8096:8096"
            "8097:8097"
            "8920:8920"
          ];
          volumes = [
            "/home/cenunix/mediaserver:/config"
            "/home/cenunix/Media/organized:/organized"
            "realdebrid:/rclone_RD"
          ];
        };
        containers.debrid = {
          image = "itstoggle/plex_debrid";
          autoStart = false;
          extraOptions = [
            "--network=host"
            "--interactive"
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
        containers.filebot = {
          image = "rednoah/filebot:node";
          autoStart = false;
          extraOptions = [
            "--network=host"
          ];
          environment = {
            TZ = "America/Los_Angeles";
            PUID = "1000";
            PGID = "1000";
            AUTO_UPDATE = "true";
            VERSION = "docker";
            XPRA_AUTH = "none";
            FILEBOT_OPTS = "-DuseExtendedFileAttributes=false";
          };
          ports = [
            "5452:5452"
          ];
          volumes = [
            "/home/cenunix/mediaserver/filebot:/data"
            "/home/cenunix/Media/organized:/organized"
            "realdebrid:/rclone_RD"
          ];
        };
        containers.jackett = {
          image = "lscr.io/linuxserver/jackett:latest";
          autoStart = true;
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
        containers.tautulli = {
          image = "ghcr.io/tautulli/tautulli";
          autoStart = true;
          extraOptions = [
            "--network=mynet123"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "America/Los_Angeles";
          };
          ports = [
            "8181:8181"
          ];
          volumes = [
            "/home/cenunix/mediaserver/tautulli:/config"
          ];
        };
        containers.plex-trakt-sync = {
          image = "ghcr.io/taxel/plextraktsync:0.26.11";
          cmd = [ "sync" ];
          extraOptions = [
            "--interactive"
            "--network=mynet123"
            "--ip=172.18.0.25"
            "--rm"
          ];
          autoStart = true;
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "America/Los_Angeles";
            PLEXAPI_PLEXAPI_TIMEOUT = "300";
          };
          volumes = [
            "/home/cenunix/mediaserver/plex-trakt-sync/config:/app/config"
          ];
        };
      };
    };
  };
}
