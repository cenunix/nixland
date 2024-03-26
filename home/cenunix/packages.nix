{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib; let
  device = osConfig.modules.device;
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
        "freeimage-unstable-2021-11-01"
      ];
      overlays = builtins.attrValues outputs.overlays;
    };
  };
  home.packages = with pkgs;
  # exclude server device type
    []
    ++ optionals (builtins.elem device.type ["desktop" "laptop" "armlaptop"]) [
      # Shared Packages between all systems
      ttyper
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
      vim
      powertop
      nh
      file
      porsmo
      wget
      gnome.zenity
      nix-prefetch-github
    ]
    ++ optionals (builtins.elem device.type ["desktop" "laptop"]) [
      ungoogled-chromium
    ]
    ++ optionals (builtins.elem device.type ["armlaptop"]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
}
