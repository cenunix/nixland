{
  inputs,
  osConfig,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    ffmpeg
    playerctl
    pavucontrol
    pulsemixer
    pulseaudio
    imv
  ];
}
