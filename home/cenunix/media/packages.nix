{
  inputs,
  osConfig,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    playerctl
    pavucontrol
    pulsemixer
    imv
  ];
}
