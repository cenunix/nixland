{ inputs, outputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.system.sound;
  device = config.modules.device;
in
{
  hardware.pulseaudio.enable = false;
  environment.systemPackages = with pkgs; [ alsa-utils ];
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
