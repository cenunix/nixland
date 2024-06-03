{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
with lib;
let
  device = osConfig.modules.device;
  simplegui = pkgs.python3Packages.buildPythonPackage rec {
    pname = "FreeSimpleGui";
    version = "5.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "spyoungtech";
      repo = "FreeSimpleGUI";
      rev = "v${version}";
      sha256 = "sha256-kUHuC5tHEd6SUIbNrad8B2BDGHyHYIfjJqWoLM4r1Bk=";
    };
    propagatedBuildInputs = with python3Packages;
      [ pkgs.python311Packages.tkinter ];

  };
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
      telegram-desktop
      ttyper
      kdePackages.tokodon
      kdePackages.zanshin
      catppuccin-kvantum
      ticktick
      wofi
      wofi-bluetooth
      gnome.nautilus
      docker
      protonvpn-gui
      networkmanagerapplet
      python311Packages.protonvpn-nm-lib
      python3
      tk
      protonup-qt
      python3Packages.pip
      python3Packages.virtualenv
      simplegui
    ] ++ optionals (builtins.elem device.type [ "desktop" ]) [ # nvtop
    ] ++ optionals (builtins.elem device.type [ "desktop" "laptop" ]) [ ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
  xdg.desktopEntries = {
    "org.kde.tokodon" = {
      name = "Tokodon";
      genericName = "Mastodon Client";
      comment = "Client for the Mastodon";
      exec = "env QT_QPA_PLATFORM=xcb ${pkgs.kdePackages.tokodon}/bin/tokodon";
      icon = "org.kde.tokodon";
      terminal = false;
      type = "Application";
    };
  };
}
