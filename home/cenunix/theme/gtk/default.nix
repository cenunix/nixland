{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig.modules) device;
  acceptedTypes = ["desktop" "laptop" "armlaptop"];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Compact-Blue-Dark";
        package = pkgs.custom-gtk.override {
          accents = ["blue"];
          tweaks = ["rimless"];
          size = "compact";
          variant = "mocha";
        };
      };
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus";
      };
      font = {
        package = pkgs.lexend;
        name = "Lexend";
        size = 13;
      };
      gtk3.extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-decoration-layout = "appmenu:none";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-error-bell = 0;
        gtk-application-prefer-dark-theme = true;
      };
      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        extraConfig = ''
          gtk-xft-antialias=1
          gtk-xft-hinting=1
          gtk-xft-hintstyle="hintslight"
          gtk-xft-rgba="rgb"
        '';
      };
    };

    # credits: bruhvko
    # catppuccin theme for qt-apps
    home.packages = with pkgs; [libsForQt5.qtstyleplugin-kvantum qt6Packages.qtstyleplugin-kvantum libsForQt5.qt5ct];

    xdg.configFile."Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Macchiato-Pink/Catppuccin-Macchiato-Pink.kvconfig";
      sha256 = "0xwv1jynmw81m70r1wk5d9cqjw37khlmf7nf2y1h3riqrzalflh6";
    };
    xdg.configFile."Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Macchiato-Pink/Catppuccin-Macchiato-Pink.svg";
      sha256 = "1pirixfhv9q59xsi2wii0r2wdapq8iii4xbwi69riblnsfgsg32m";
    };
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin

      [Applications]
      catppuccin=Dolphin, dolphin, Nextcloud, nextcloud, qt5ct, org.kde.dolphin, org.kde.kalendar, kalendar, Kalendar, qbittorrent, org.qbittorrent.qBittorrent
    '';
  };
}
