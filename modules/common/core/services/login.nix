{ config, lib, pkgs, asztal, self, ... }:
with lib;
let
  env = config.modules.usrEnv;
  sys = config.modules.system;
  sessionData = config.services.xserver.displayManager.sessionData.desktops;
  sessionPath = concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];
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
      greetd = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };
    };

    # systemd.tmpfiles.rules = [
    #   "d '/var/cache/greeter' - greeter greeter - -"
    # ];
    #
    # system.activationScripts.wallpaper = ''
    #   PATH=$PATH:${pkgs.busybox}/bin:${pkgs.jq}/bin
    #   CACHE="/var/cache/greeter"
    #   OPTS="$CACHE/options.json"
    #   HOME="/home/$(find /home -maxdepth 1 -printf '%f\n' | tail -n 1)"
    #
    #   cp $HOME/.cache/ags/options.json $OPTS
    #   chown greeter:greeter $OPTS
    #
    #   BG=$(cat $OPTS | jq -r '.wallpaper // "$HOME/.config/background"')
    #   cp $BG $CACHE/background
    #   chown greeter:greeter $CACHE/background
    # '';

    services = {
      xserver.displayManager.session = [{
        manage = "desktop";
        name = "hyprland";
        start = ''
          Hyprland
        '';
      }];

      greetd = mkIf env.windowManager {
        enable = true;
        vt = 2;
        restart = !env.autologin;
        settings = {
          # pick up desktop variant (i.e Hyprland) and username from usrEnv
          # this option is usually defined in host/<hostname>/system.nix
          initial_session = mkIf env.autologin {
            command = "${env.desktop}";
            user = "${sys.username}";
          };

          default_session = if (!env.autologin) then {
            #   command = pkgs.writeShellScript "greeter" ''
            #     export XKB_DEFAULT_LAYOUT=${config.services.xserver.xkb.layout}
            #     export XCURSOR_THEME=Qogir
            #     ${self}/bin/greeter
            #   '';
            #   # user = "greeter";
            # }
            command = lib.concatStringsSep " " [
              (getExe pkgs.greetd.tuigreet)
              "--time"
              "--remember"
              "--remember-user-session"
              "--asterisks"
              "--power-shutdown '${pkgs.systemd}/bin/systemctl shutdown'"
              "--sessions '${sessionPath}'"
            ];
            user = "greeter";
          } else {
            command = "${env.desktop}";
            user = "${sys.username}";
          };
        };
      };

      gnome = {
        glib-networking.enable = true;
        gnome-keyring.enable = true;
      };

      logind = if (sys.server.enable) then {
        lidSwitch = "ignore";
        lidSwitchExternalPower = "ignore";
      } else {
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
