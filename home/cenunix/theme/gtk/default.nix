{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, ...
}:
with lib; let
  device = osConfig.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Compact-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "blue" ];
          tweaks = [ "rimless" ];
          size = "compact";
          variant = "mocha";
        };
      };
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus";
      };
      font = {
        package = pkgs.fira;
        name = "Fira Sans Condensed";
        size = 13;
      };
      gtk3.extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
      };
      gtk2.extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };

    # cursor theme
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    home.sessionVariables = {
      # XCURSOR_SIZE = lib.mkOverride "16";
      XCURSOR_SIZE = "16";
      GTK_USE_PORTAL = "1";
    };

    # credits: bruhvko
    # catppuccin theme for qt-apps
    home.packages = with pkgs; [ libsForQt5.qtstyleplugin-kvantum libsForQt5.qt5ct ];

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
