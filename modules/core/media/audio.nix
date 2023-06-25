{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol
  ];
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = false;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
