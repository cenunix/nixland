{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
with lib;
let device = osConfig.modules.device;
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
      # telegram-desktop
      ttyper
      # kdePackages.tokodon
      # kdePackages.zanshin
      # catppuccin-kvantum
      # ticktick
      wofi
      # docker
      # networkmanagerapplet
    ] ++ optionals (builtins.elem device.type [ "desktop" ]) [
      # nvtop
    ] ++ optionals (builtins.elem device.type [ "desktop" "laptop" ]) [ ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
  # xdg.desktopEntries = {
  #   "org.kde.tokodon" = {
  #     name = "Tokodon";
  #     genericName = "Mastodon Client";
  #     comment = "Client for the Mastodon";
  #     exec = "env QT_QPA_PLATFORM=xcb ${pkgs.kdePackages.tokodon}/bin/tokodon";
  #     icon = "org.kde.tokodon";
  #     terminal = false;
  #     type = "Application";
  #   };
  # };
}
