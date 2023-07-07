{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  device = config.modules.device;
in {
  config = {
    modules = {
      device = {
        type = "laptop";
        cpu = "intel";
        gpu = "intel";
        monitors = [
          "eDP-1,1920x1080@60,auto,1"
        ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        video.enable = true;
        sound.enable = true;
        bluetooth.enable = true;
        username = "cenunix";
      };
      usrEnv = {
        isWayland = true;
        desktop = "Hyprland";
        useHomeManager = true;
        autologin = true;
      };
    };
  };
}
