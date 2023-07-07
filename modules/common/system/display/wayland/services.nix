{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib; let
  usr =
    if (config.modules.system.username == null)
    then "cenunix"
    else "${config.modules.system.username}";
  env = config.modules.usrEnv;
in {
  config = mkIf (env.isWayland) {
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
        wantedBy = ["multi-user.target"];
      };
    };

    services = {
      greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "Hyprland";
            user = "${usr}";
          };
          default_session = initial_session;
        };
      };

      gnome = {
        glib-networking.enable = true;
        gnome-keyring.enable = true;
      };
      dbus = {
        packages = with pkgs; [dconf gcr udisks2];
        enable = true;
      };
      logind = {
        lidSwitch = "suspend-then-hibernate";
        lidSwitchExternalPower = "lock";
        extraConfig = ''
          HandlePowerKey=suspend-then-hibernate
          HibernateDelaySec=3600
        '';
      };

      lorri.enable = true;
      udisks2.enable = true;
      printing.enable = true;
      fstrim.enable = true;
    };
  };
}
