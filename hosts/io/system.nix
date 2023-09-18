{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  device = config.modules.device;
in
{
  config = {
    modules = {
      device = {
        type = "server";
        cpu = "intel";
        gpu = "intel";
        monitors = [
          "eDP-1,1920x1080@60,auto,1"
        ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        boot = {
          loader = "systemd-boot";
        };
        video.enable = true;
        sound.enable = true;
        bluetooth.enable = true;
        username = "cenunix";
        server = {
          enable = true;
          mediaServer = true;
        };
      };
      programs = {
        cli.enable = true;
        gui.enable = true;

        gaming = {
          enable = false;
          steam.enable = false;
          chess.enable = false;
          minecraft.enable = false;
        };
        override = { };
      };
      usrEnv = {
        isWayland = false;
        windowManager = false;
        useHomeManager = true;
        autologin = false;
      };
    };
  };
}
