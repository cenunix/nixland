{ inputs, osConfig, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    mpv
    playerctl
    pavucontrol
    pulsemixer
    pulseaudio
    imv
    nextcloud-client
    virtiofsd
  ];
}
