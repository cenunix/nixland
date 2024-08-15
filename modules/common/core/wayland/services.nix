{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
with lib;
let env = config.modules.usrEnv;
in {
  config = mkIf (env.isWayland) {
    services.xserver.enable = true;
    # services.xserver.displayManager.sddm.enable = true;
    # services.xserver.desktopManager.plasma6.enable = true;
    # services.xserver.displayManager.defaultSession = "plasmax11";
    systemd.services = {
      seatd = {
        enable = true;
        description = "Seat management daemon";
        script = "${pkgs.seatd}/bin/seatd -g wheel";
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };
    security.wrappers = {
      gpu-screen-recorder = {
        owner = "root";
        group = "video";
        capabilities = "cap_sys_nice+ep";
        source = "${pkgs.gpu-screen-recorder-mine}/bin/gpu-screen-recorder";
      };

      gsr-kms-server = {
        owner = "root";
        group = "video";
        capabilities = "cap_sys_admin+ep";
        source = "${pkgs.gpu-screen-recorder-mine}/bin/gsr-kms-server";
      };
    };

  };
}
