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
    [
      # Shared Packages between all systems
      networkmanagerapplet
      nitch
      inputs.agenix.packages.${pkgs.system}.default
      linuxKernel.packages.linux_zen.cpupower
      youtube-dl
      vlc
      ffmpeg
      mpvpaper
      mpv
    ]
    ++ optionals (builtins.elem device.type [ "desktop" "laptop" ]) [
      lunatask
    ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
}
