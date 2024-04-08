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
    jellyfin-media-player
    jellycli
    plexamp
    tidal-hifi
  ];
}
