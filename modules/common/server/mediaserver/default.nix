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
  service-name = "${config.virtualisation.oci-containers.backend}-debrid";
in
{

  config = mkIf (cfg.mediaServer) {
    systemd.services.${service-name} = {
      preStart = ''sleep 30'';
      serviceConfig = {
        Restart = "always";
        TimeoutStartSec = lib.mkForce 35;
        TimeoutStopSec = lib.mkForce 15;
      };
      wantedBy = [ "graphical.target" ];
      # partOf = [
      #   "docker-plex.service"
      #   "docker-jackett.service"
      # ];
    };
    systemd.services.foo = {
      script = ''
        if ${pkgs.docker}/bin/docker run --rm -i -v=realdebrid:/tmp/myvolume busybox find /tmp/myvolume | grep -q '/tmp/myvolume'; then
          systemctl stop docker-plex
          mkdir -p /var/lib/docker-plugins/rclone/config
          mkdir -p /var/lib/docker-plugins/rclone/cache
          ${pkgs.docker}/bin/docker volume prune -f
          ${pkgs.docker}/bin/docker plugin inspect rclone >/dev/null 2>&1 || ${pkgs.docker}/bin/docker plugin install itstoggle/docker-volume-rclone_rd:amd64 args="-v" --alias rclone --grant-all-permissions config=/var/lib/docker-plugins/rclone/config cache=/var/lib/docker-plugins/rclone/cache
          ${pkgs.docker}/bin/docker volume inspect realdebrid >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create realdebrid -d rclone -o type=realdebrid -o allow-other=true -o dir-cache-time=10s -o realdebrid-api_key=${builtins.readFile config.age.secrets.mediaserver.path}
          systemctl start docker-plex
        fi
      '';
      wantedBy = [ "graphical.target" ];
      serviceConfig = {
        Type = "oneshot";
      };
    };
    systemd.extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    # systemd.services.plex_debrid = {
    #   script = ''
    #     if [ ! "$(${pkgs.docker}/bin/docker ps -a -q -f name=debrid)" ]; then
    #       if [ "$(${pkgs.docker}/bin/docker ps -aq -f status=exited -f name=debrid)" ]; then
    #         # cleanup
    #         ${pkgs.docker}/bin/docker rm debrid
    #       fi
    #       # run your container
    #       ${pkgs.docker}/bin/docker run -v /home/cenunix/Videos/mediaserver/plex_debrid:/config --name debrid --net host -t itstoggle/plex_debrid
    #     fi
    #   '';
    #   serviceConfig = {
    #     Type = "oneshot";
    #   };
    #   wantedBy = [ "graphical.target" ];
    #   after = [ "foo.service" ];
    # };

    virtualisation = {
      docker = {
        enable = true;
        enableNvidia = true;
      };
      oci-containers = {
        backend = "docker";

        containers.plex = {
          image = "lscr.io/linuxserver/plex:latest";
          autoStart = true;
          # cmd = [
          #   "--volume-driver=rclone"
          # ];
          extraOptions = [
            "--network=host"
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
            "/home/cenunix/Videos/mediaserver:/config"
            "realdebrid:/torrents"
          ];
        };
        containers.debrid = {
          image = "itstoggle/plex_debrid";
          autoStart = true;
          # cmd = [
          #   "--volume-driver=rclone"
          # ];
          extraOptions = [
            "--network=host"
            "--interactive"
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
            "/home/cenunix/Videos/mediaserver/plex_debrid:/config"
          ];
        };
        containers.jackett = {
          image = "lscr.io/linuxserver/jackett:latest";
          autoStart = true;
          # extraOptions = [
          # "--restart=unless-stopped"
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
            "/home/cenunix/Videos/mediaserver:/config"
            "/dev/null:/downloads"
          ];
          # extraOptions = [ "--pull=always" ];
        };
      };
    };
  };
}
