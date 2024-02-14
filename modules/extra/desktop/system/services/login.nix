{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  env = config.modules.usrEnv;
  sys = config.modules.system;
in {
  config = {
    # unlock GPG keyring on login
    security.pam.services = {
      login = {
        enableGnomeKeyring = true;
        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      };
    };
    #   greetd = {
    #     gnupg.enable = true;
    #     enableGnomeKeyring = true;
    #   };
    # };
    # programs.qtgreet = {
    #   package = pkgs.qtgreet;
    #   enable = true;
    # };
    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols
      libsForQt5.qt5.qtgraphicaleffects
      catppuccin-sddm-corners
    ];
    services = {
      #   greetd = mkIf env.windowManager {
      #     enable = true;
      #     vt = 2;
      #     restart = !env.autologin;
      #     settings = {
      #       # pick up desktop variant (i.e Hyprland) and username from usrEnv
      #       # this option is usually defined in host/<hostname>/system.nix
      #       initial_session = mkIf env.autologin {
      #         command = "${env.desktop}";
      #         user = "${sys.username}";
      #       };
      #
      #       default_session =
      #         if (!env.autologin)
      #         then {
      #           command = lib.concatStringsSep " " [
      #             "'${pkgs.hyprland}/bin/Hyprland' --config /etc/hypr.conf"
      #             # (lib.getExe pkgs.qtgreet)
      #             # "--time"
      #             # "--remember"
      #             # "--remember-user-session"
      #             # "--asterisks"
      #             # "--power-shutdown '${pkgs.systemd}/bin/systemctl shutdown'"
      #             #"--sessions '${sessionPath}'"
      #           ];
      #           user = "greeter";
      #         }
      #         else {
      #           command = "${env.desktop}";
      #           user = "${sys.username}";
      #         };
      #     };
      #   };

      xserver = {
        libinput.enable = true;
        enable = true;
      };
      xserver.displayManager.sessionPackages = [pkgs.hyprland];
      xserver.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "catppuccin-sddm-corners";
      };
      gnome = {
        glib-networking.enable = true;
        gnome-keyring.enable = true;
      };

      logind =
        if (sys.server.enable)
        then {
          lidSwitch = "ignore";
          lidSwitchExternalPower = "ignore";
        }
        else {
          lidSwitch = "suspend-then-hibernate";
          lidSwitchExternalPower = "lock";
          extraConfig = ''
            HandlePowerKey=suspend-then-hibernate
            HibernateDelaySec=3600
          '';
        };
    };
  };
}
