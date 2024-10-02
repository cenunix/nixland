{ inputs, outputs, lib, config, pkgs, ... }:
with lib;
let device = config.modules.device;
in {
  config = {
    modules = {
      device = {
        type = "armlaptop";
        monitors = [ ",preferred,auto,1.2" ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        username = "cenunix";
        boot = { loader = "x13s-boot"; };
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
        default = {
          terminal = "kitty";
          fileManager = "thunar";
        };
        override = { };
      };
      style = {
        pointerCursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
      };
      usrEnv = {
        isWayland = true;
        windowManager = true;
        desktop = "Hyprland";
        useHomeManager = true;
        autologin = false;
      };
    };
  };
}
