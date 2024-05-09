{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
let
  inherit (lib) mkIf;
  inherit (osConfig.modules) device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      (pkgs.catppuccin-kde.override {
        flavour = [ "mocha" ];
        accents = [ "blue" ];
        winDecStyles = [ "modern" ];
      })
    ];

    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".source =
        (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
          General.theme = "catppuccin";
          Applications.catppuccin = ''
            qt5ct, org.kde.dolphin, org.kde.kalendar, org.qbittorrent.qBittorrent, hyprland-share-picker, dolphin-emu, Nextcloud, nextcloud, cantata, org.kde.kid3-qt
          '';
        };
      "Kvantum/catppuccin/catppuccin.kvconfig".source =
        ./themes/Catppuccin-Mocha-Blue.kvconfig;
      "Kvantum/catppuccin/catppuccin.svg".source =
        ./themes/Catppuccin-Mocha-Blue.svg;
    };

    qt = {
      enable = true;
      platformTheme = "qtct";
      style.name = "kvantum";
    };
  };
}
