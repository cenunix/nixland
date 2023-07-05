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
          ",preferred,auto,1"
        ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        video.enable = true;
        sound.enable = true;
        bluetooth.enable = true;
        username = "exht";
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
