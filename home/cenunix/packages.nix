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
      telegram-desktop
      ttyper
      kdePackages.tokodon
      kdePackages.zanshin
      catppuccin-kvantum
      youtube-music
      # vencord
      # my-vesktop
      (vesktop.overrideAttrs (o: rec {
        version = "master";
        src = o.src.override {
          rev = "ab9e8579eea046187c5cdb51e2041a0beb6e8601";
          hash = "sha256-s3ndHHN8mqbzL40hMDXXDl+VV9pOk4XfnaVCaQvFFsg=";
        };
        pnpmDeps = o.pnpmDeps.overrideAttrs (o: rec {
          outputHash = "sha256-6ezEBeYmK5va3gCh00YnJzZ77V/Ql7A3l/+csohkz68=";
        });
      })).override
      { vencord = owo-vencord; }
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
