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
        type = "desktop";
        cpu = "amd";
        gpu = "nvidia";
        monitors = [
          "DP-1,2560x1440@240,auto,1"
          "DP-2,1920x1080@240,auto,1"
        ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        username = "cenunix";
        video.enable = true;
        sound.enable = true;
        bluetooth.enable = true;
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
