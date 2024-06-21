{ inputs, osConfig, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    mpv
    ffmpeg
    playerctl
    pavucontrol
    pulsemixer
    pulseaudio
    imv
    nextcloud-client
    jellyfin-media-player
  ];
}
