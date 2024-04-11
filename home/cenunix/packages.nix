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
      #tools
      unzip
      ripgrep
      fd
      xh
      jq
      fzf
      p7zip
      grex
      lm_sensors
      dua
      unrar
      powertop
      nh
      file
      wget
      gnome.zenity
      nix-prefetch-github
      #actual apps
      telegram-desktop
      ttyper
      wofi
      wofi-bluetooth
      wireshark
    ] ++ optionals (builtins.elem device.type [ "desktop" ]) [ nvtop ]
    ++ optionals (builtins.elem device.type [ "desktop" "laptop" ]) [ ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
}
