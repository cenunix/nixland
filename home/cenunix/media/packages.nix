{
  inputs',
  osConfig,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    ffmpeg-full
    yt-dlp
    playerctl
    pavucontrol
    pulsemixer
    imv
    mov-cli
    ani-cli
  ];
}
