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
        type = "armlaptop";
        monitors = [
          ",preferred,auto,1"
        ];
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
