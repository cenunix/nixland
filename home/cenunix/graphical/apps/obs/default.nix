{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
with lib;
let
  device = osConfig.modules.device;
  env = osConfig.modules.usrEnv;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    programs = {
      obs-studio = {
        enable = true;

        plugins = with pkgs.obs-studio-plugins;
          [ obs-gstreamer obs-pipewire-audio-capture obs-vkcapture ]
          ++ optional env.isWayland pkgs.obs-studio-plugins.wlrobs;
      };
    };
  };
}
