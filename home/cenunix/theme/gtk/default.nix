{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
let
  inherit (lib) mkIf;
  inherit (osConfig.modules) device;
  inherit (osConfig.modules.style) pointerCursor;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.pointerCursor = {
      package = pointerCursor.package;
      name = pointerCursor.name;
      size = pointerCursor.size;
      gtk.enable = true;
      x11.enable = true;
    };
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Compact-Blue-Dark";
        package = pkgs.custom-gtk.override {
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
  };
}
