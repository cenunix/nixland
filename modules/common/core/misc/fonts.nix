{ inputs, outputs, lib, config, pkgs, ... }:
with lib;
let
  device = config.modules.device;
  acceptedTypes = [ "server" "desktop" "laptop" "armlaptop" "hybrid" "lite" ];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    nixpkgs.config.joypixels.acceptLicense = true;

    fonts = {
      packages = with pkgs; [
        iosevka-bin
        font-awesome
        jetbrains-mono
        maple-mono
        maple-mono-NF
        maple-mono-SC-NF
        lexend
        joypixels
        nerdfonts
      ];

      enableDefaultPackages = false;

      # this fixes emoji stuff
      fontconfig = {
        defaultFonts = {
          monospace = [
            # "Maple Mono"
            "Maple Mono SC NF"
            # "JoyPixels"
          ];
          sansSerif = [ "Lexend" "JoyPixels" ];
          serif = [ "Lexend" "JoyPixels" ];
          emoji = [ "JoyPixels" ];
        };
      };
    };
  };
}
