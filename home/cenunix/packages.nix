{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
with lib;
let
  device = osConfig.modules.device;
  pythonDeps = [ pkgs.python312Packages.pybind11 ];
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      permittedInsecurePackages =
        [ "electron-25.9.0" "freeimage-unstable-2021-11-01" ];
      overlays = builtins.attrValues outputs.overlays;
    };
  };
  home.packages = with pkgs;
  # exclude server device type
    [ ] ++ optionals
    # shared packages between all systems
    (builtins.elem device.type [ "desktop" "laptop" "armlaptop" ]) [
      #actual apps
      ttyper
      wofi
      wpa_supplicant_gui
      wofi-bluetooth
      gsettings-desktop-schemas
      # nicotine-plus
      swww
      hyprpicker
      gnome-podcasts
      python39
      grimblast
      cider-2
      libreoffice
      libnotify
      # protonmail-desktop
      # kdePackages.tokodon
      # docker-compose
      # gnome-weather
      telegram-desktop
      (discord-canary.override { withVencord = true; })
      bitwarden-desktop
      # inputs.spmp.packages.${pkgs.system}.default
    ] ++ optionals (builtins.elem device.type [ "desktop" ]) [ ryujinx plexamp ]
    ++ optionals (builtins.elem device.type [ "desktop" "laptop" ]) [ ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
  # xdg.desktopEntries = {
  #   "org.kde.tokodon" = {
  #     name = "Firefox-beta";
  #     genericName = "Mastodon Client";
  #     comment = "Client for the Mastodon";
  #     exec = "env QT_QPA_PLATFORM=xcb ${pkgs.kdePackages.tokodon}/bin/tokodon";
  #     icon = "org.kde.tokodon";
  #     terminal = false;
  #     type = "Application";
  #   };
  # };
}
