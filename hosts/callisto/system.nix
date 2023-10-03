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
        type = "armlaptop";
        monitors = [
          ",preferred,auto,1.3"
        ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        username = "cenunix";
        boot = {
          loader = "x13s-boot";
        };
        video.enable = true;
        sound.enable = true;
        bluetooth.enable = true;
      };
      programs = {
        cli.enable = true;
        gui.enable = true;

        gaming = {
          enable = false;
          chess.enable = false;
          steam.enable = false;
        };
        override = { };
      };
      usrEnv = {
        isWayland = true;
        windowManager = true;
        desktop = "Hyprland";
        useHomeManager = true;
        autologin = true;
      };
    };
  };
}
