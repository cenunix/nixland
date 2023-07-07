{
  lib,
  pkgs,
  osConfig,
  ...
}:
with lib; let
  programs = osConfig.modules.programs;
  device = osConfig.modules.device;

  acceptedTypes = ["laptop" "desktop" "lite"];
in {
  imports = [
    ./minecraft
  ];

  config = mkIf ((builtins.elem device.type acceptedTypes) && (programs.gaming.enable)) {
    home = {
      packages = with pkgs;
        [
          mangohud
          lutris
          dolphin-emu # cool emulator
          mgba # GBA emulation
        ]
        ++ optionals (programs.gaming.steam.enable) [
          gamescope
          legendary-gl
          winetricks
          lutris
        ];
    };
  };
}
