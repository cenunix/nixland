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
      ];
    };
  };
  home.packages = with pkgs;
  # exclude server device type
    []
    ++ optionals (builtins.elem device.type ["desktop" "laptop" "armlaptop"]) [
      # Shared Packages between all systems
      mpv
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
    ]
    ++ optionals (builtins.elem device.type ["desktop" "laptop"]) [
      lunatask
      brave
    ]
    ++ optionals (builtins.elem device.type ["armlaptop"]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
}
