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
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  home.packages = with pkgs;
    # exclude server device type
    [ ]
    ++ optionals (builtins.elem device.type [ "desktop" "laptop" "armlaptop" ]) [
      # Shared Packages between all systems
      networkmanagerapplet
      nitch
      inputs.agenix.packages.${pkgs.system}.default
      linuxKernel.packages.linux_zen.cpupower
      gparted
      polkit
      libsForQt5.polkit-kde-agent
      polkit_gnome
      xorg.xhost
      mission-center
      mpv
      stremio
      hexchat
    ]
    ++ optionals (builtins.elem device.type [ "desktop" "laptop" ]) [
      lunatask
    ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
}
