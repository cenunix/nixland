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
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
  home.packages = with pkgs;
    # exclude server device type
    [ ]
    ++ optionals (builtins.elem device.type [ "desktop" "laptop" "armlaptop" ]) [
      # Shared Packages between all systems
      networkmanagerapplet
      nitch
      polkit
      polkit_gnome
      mpv
      hexchat
      stremio
      lame
    ]
    ++ optionals (builtins.elem device.type [ "desktop" "laptop" ]) [
      lunatask
    ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
}
