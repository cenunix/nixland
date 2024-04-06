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
          "DP-1,2560x1440@239.970001,auto,1"
          "DP-2,1920x1080@240,auto,1"
        ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        username = "cenunix";
        boot = {
          loader = "systemd-boot";
        };
        video.enable = true;
        sound.enable = true;
        bluetooth.enable = true;
        virtualization.enable = true;
        virtualization.qemu.enable = true;
        server = {
          enable = false;
          mediaServer = false;
        };
      };
      programs = {
        cli.enable = true;
        gui.enable = true;

        gaming = {
          enable = true;
          steam.enable = true;
          chess.enable = false;
          minecraft.enable = false;
          gamescope.enable = false;
        };
        default = {
          terminal = "kitty";
          fileManager = "thunar";
        };
        override = {};
      };
      usrEnv = {
        isWayland = true;
        desktop = "Hyprland";
        windowManager = true;
        useHomeManager = true;
        autologin = false;
      };
    };
  };
}
