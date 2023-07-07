{
  lib,
  pkgs,
  osConfig,
  ...
}:
with lib; let
  programs = osConfig.modules.programs;
  device = osConfig.modules.device;

  acceptedTypes = ["laptop" "desktop" "armlaptop"];
in {
  imports = [
    ./minecraft
  ];

  config = mkIf ((builtins.elem device.type acceptedTypes) && (programs.gaming.enable)) {
    home = {
      packages = with pkgs;
        [
          dolphin-emu # cool emulator
          mgba # GBA emulation
        ]
        ++ optionals (programs.gaming.steam.enable) [
          gamescope
          mangohud # nice fps/temp overlay
          winetricks
          lutris
        ];
    };
  };
}
