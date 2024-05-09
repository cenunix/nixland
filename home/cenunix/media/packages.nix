{ inputs, osConfig, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    mpv
    vlc
    ffmpeg
    playerctl
    pavucontrol
    pulsemixer
    pulseaudio
    imv
    plex-mpv-shim
    nextcloud-client
  ];
}
