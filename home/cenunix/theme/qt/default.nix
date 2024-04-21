{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
let
  inherit (lib) mkIf;
  inherit (osConfig.modules) device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      # (pkgs.catppuccin-kde.override {
      #   flavour = [ "mocha" ];
      #   accents = [ "blue" ];
      #   winDecStyles = [ "modern" ];
      # })
    ];

    xdg.configFile."Kvantum/catppuccin/catppuccin.kvconfig".source =
      ./themes/Catppuccin-Mocha-Blue.kvconfig;
    xdg.configFile."Kvantum/catppuccin/catppuccin.svg".source =
      ./themes/Catppuccin-Mocha-Blue.svg;
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin

      [Applications]
      catppuccin=Dolphin, dolphin, org.kde.tokodon, Tokodon, tokodon, Nextcloud, nextcloud, qt5ct, org.kde.dolphin, org.kde.kalendar, kalendar, Kalendar, qbittorrent, org.qbittorrent.qBittorrent
    '';

    qt = {
      enable = true;
      platformTheme = "qtct";
      style.name = "kvantum";
    };
  };
}
