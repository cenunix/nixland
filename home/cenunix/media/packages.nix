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
<<<<<<< HEAD
    plex-mpv-shim
    nextcloud-client
||||||| parent of 357e147 (update config on x13s)
    jellyfin-media-player
    jellycli
    plexamp
    tidal-hifi
=======
    jellyfin-media-player
>>>>>>> 357e147 (update config on x13s)
  ];
}
