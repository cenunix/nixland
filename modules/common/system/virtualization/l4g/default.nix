{ lib, config, pkgs, ... }:
with lib;
let sys = config.modules.system.virtualization;
in {
  config = mkIf (sys.enable) {

    virtualisation.docker.enable = true;

    # virtualisation.oci-containers.containers."l4g-upload" = {
    #   environment = {
    #     TZ = "America/Vancouver";
    #     # PUID = ;
    #     # PGID = toString config.users.groups.media.gid;
    #   };
    #   extraOptions = [ "--network=host" ];
    #   image = "l4gsp1ke/upload-assistant";
    #   volumes = [
    #     "/mnt/smb_share/qbit/downloads/movies:/downloads"
    #     "/mnt/appdata/binhex-qbittorrentvpn/qBittorrent/data/BT_backup:/BT_backup"
    #   ];
    # };
  };
}
